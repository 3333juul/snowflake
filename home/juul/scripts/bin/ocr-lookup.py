#!/usr/bin/env python3
"""
Translates the text located closest to the mouse cursor.

Process:
  cursor position (mmsg)
  -> small screenshot around the cursor (grim, without saving to disk)
  -> OCR (tesseract)
  -> word whose center is closest to the cursor
  -> translation using the offline sdcv dictionary
  -> copy the recognized word to the clipboard
  -> display the result in a Kitty terminal

Requirements:
  - mmsg
  - grim
  - tesseract
  - python-pytesseract
  - python-pillow
  - sdcv
  - StarDict dictionary for sdcv
  - wl-copy
  - kitty
"""

import errno
import io
import json
import os
import subprocess
import sys
import time

from PIL import Image
import pytesseract


REGION_SIZE = 160
TESS_CONFIG = "--oem 1 --psm 11"
FIFO_PATH = "/tmp/translate_term.fifo"


# --- kursor / screenshot / OCR ----------------------------------------------

def get_cursor_position():
    result = subprocess.run(
        ["mmsg", "get", "cursorpos"],
        capture_output=True,
        text=True,
        timeout=1,
    )

    if result.returncode != 0:
        raise RuntimeError(
            f"Nie udalo sie pobrac pozycji kursora: {result.stderr}"
        )

    data = json.loads(result.stdout)
    return int(data["x"]), int(data["y"])


def take_screenshot_around_cursor(
    cursor_x,
    cursor_y,
    region_size=REGION_SIZE,
):
    half = region_size // 2

    x1 = cursor_x - half
    y1 = cursor_y - half

    geometry = f"{x1},{y1} {region_size}x{region_size}"

    # "-" jako sciezka wyjscia -> grim pisze PNG na stdout,
    # bez zapisu na dysk.
    result = subprocess.run(
        ["grim", "-g", geometry, "-"],
        capture_output=True,
        timeout=2,
    )

    if result.returncode != 0:
        raise RuntimeError(
            "Nie udalo sie zrobic screenshota: "
            + result.stderr.decode(errors="ignore")
        )

    return Image.open(io.BytesIO(result.stdout))


def perform_ocr(image):
    image = image.convert("L")

    # Prosta binaryzacja obrazu:
    # czarne tlo/biale znaki lub odwrotnie zależnie od obrazu.
    image = image.point(lambda p: 255 if p > 128 else 0)

    return pytesseract.image_to_data(
        image,
        config=TESS_CONFIG,
        output_type=pytesseract.Output.DICT,
    )


def find_center_text(data, region_size):
    center = region_size / 2

    best_dist = float("inf")
    best_text = ""

    for text, x, y, w, h in zip(
        data["text"],
        data["left"],
        data["top"],
        data["width"],
        data["height"],
    ):
        text = text.strip()

        if not text:
            continue

        cx = x + w / 2
        cy = y + h / 2

        dist = (cx - center) ** 2 + (cy - center) ** 2

        if dist < best_dist:
            best_dist = dist
            best_text = text

    return best_text


# --- tlumaczenie przez sdcv --------------------------------------------------

def sdcv_lookup(word):
    """
    Wyszukuje slowo w lokalnych slownikach StarDict przez sdcv.

    Zwraca:
        tekst wyniku sdcv
    albo:
        None, jesli nie znaleziono wyniku / sdcv nie jest zainstalowane.
    """

    try:
        result = subprocess.run(
            [
                "sdcv",
                "-n",
                "--utf8-output",
                "--color",
                word,
            ],
            capture_output=True,
            text=True,
            timeout=1,
        )

    except FileNotFoundError:
        return None

    except subprocess.TimeoutExpired:
        return None

    output = result.stdout.strip()

    if not output:
        return None

    if output.startswith("Nothing similar"):
        return None

    return output


def translate_text(text):
    """
    Tlumaczenie wylacznie przez sdcv.

    sdcv jest uzywane dla pojedynczego slowa.
    """

    word = text.strip()

    if not word:
        return None

    # Ten skrypt tlumaczy pojedyncze slowa.
    if " " in word:
        return "sdcv: wykryto wiecej niz jedno slowo."

    return sdcv_lookup(word)


# --- wynik w ponownie wykorzystywanym terminalu ------------------------------

def terminal_is_open():
    result = subprocess.run(
        [
            "pgrep",
            "-f",
            f"tail -f -n 0 {FIFO_PATH}",
        ],
        capture_output=True,
    )

    return result.returncode == 0


def open_terminal():
    if os.path.exists(FIFO_PATH):
        os.remove(FIFO_PATH)

    os.mkfifo(FIFO_PATH)

    subprocess.Popen(
        [
            "kitty",
            "--class",
            "floatingterm",
            "-e",
            "tail",
            "-f",
            "-n",
            "0",
            FIFO_PATH,
        ],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )


def send_to_terminal(message, timeout=4):
    deadline = time.time() + timeout
    fd = None

    while time.time() < deadline:
        try:
            fd = os.open(
                FIFO_PATH,
                os.O_WRONLY | os.O_NONBLOCK,
            )
            break

        except OSError as e:
            if e.errno == errno.ENXIO:
                # Nikt jeszcze nie czyta z FIFO - czekamy.
                time.sleep(0.05)
                continue

            raise

    if fd is None:
        raise RuntimeError(
            "Terminal nie odpowiedzial na czas"
        )

    with os.fdopen(fd, "w") as f:
        f.write(message + "\n")


def show_result(message):
    """
    Jesli terminal z poprzedniego uruchomienia nadal istnieje,
    dopisujemy wynik do niego.

    Jesli nie - otwieramy nowy terminal Kitty.
    """

    if not terminal_is_open():
        open_terminal()

    send_to_terminal(message)


# --- schowek ------------------------------------------------------------------

def copy_to_clipboard(text):
    subprocess.run(
        ["wl-copy"],
        input=text.encode("utf-8"),
        timeout=1,
    )


# --- main ---------------------------------------------------------------------

def main():
    # 1. Pozycja kursora
    cursor_x, cursor_y = get_cursor_position()

    # 2. Screenshot wokol kursora
    image = take_screenshot_around_cursor(
        cursor_x,
        cursor_y,
    )

    # 3. OCR
    ocr_data = perform_ocr(image)

    # 4. Znajdz slowo najblizej centrum screenshotu
    closest_text = find_center_text(
        ocr_data,
        REGION_SIZE,
    )

    if not closest_text:
        print("Nie znaleziono tekstu przy kursorze")
        return

    print(f"Znaleziony tekst: {closest_text}")

    # 5. Tlumaczenie TYLKO przez sdcv
    translated_text = translate_text(closest_text)

    if not translated_text:
        translated_text = "Brak wyniku w sdcv."

    print(f"Tlumaczenie: {translated_text}")

    # 6. Kopiuj znalezione slowo do schowka
    copy_to_clipboard(closest_text)

    # 7. Pokaz wynik w Kitty
    header = closest_text

    show_result(
        f"{header}\n"
        f"{'-' * len(header)}\n"
        f"{translated_text}"
    )


if __name__ == "__main__":
    try:
        main()

    except Exception as e:
        print(
            f"Blad: {e}",
            file=sys.stderr,
        )
        sys.exit(1)
