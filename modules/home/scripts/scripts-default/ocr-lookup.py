import subprocess
import pytesseract
from PIL import Image
import sys


# get cursor position
def get_cursor_position():
    result = subprocess.run(["hyprctl", "cursorpos"], capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError("Failed to get cursor position")
    x, y = map(int, result.stdout.strip().split(","))
    return x, y


# take a screenshot
def take_screenshot_around_cursor(
    cursor_x, cursor_y, region_size=200, output_path="screenshot.png"
):
    half_size = region_size // 2
    x1, y1 = cursor_x - half_size, cursor_y - half_size

    # Use grim to take a region screenshot
    geometry = f"{x1},{y1} {region_size}x{region_size}"
    result = subprocess.run(["grim", "-g", geometry, output_path], capture_output=True)
    if result.returncode != 0:
        raise RuntimeError("Failed to take screenshot")
    return output_path


# perform OCR using Tesseract
def perform_ocr(image_path):
    image = Image.open(image_path)

    # preprocessing to improve speed and accuracy
    image = image.convert("L")  # Convert to grayscale
    image = image.point(lambda p: p > 128 and 255)  # Simple threshold

    data = pytesseract.image_to_data(image, output_type=pytesseract.Output.DICT)
    return data


# find the text in the center of the screenshot
def find_center_text(data, region_size):
    # calculate the center of the region
    center_x = region_size // 2
    center_y = region_size // 2
    closest_distance = float("inf")
    closest_text = ""

    for i in range(len(data["text"])):
        if data["text"][i].strip():
            x, y, w, h = (
                data["left"][i],
                data["top"][i],
                data["width"][i],
                data["height"][i],
            )
            center_of_text_x, center_of_text_y = x + w // 2, y + h // 2
            distance = (
                (center_of_text_x - center_x) ** 2 + (center_of_text_y - center_y) ** 2
            ) ** 0.5

            if distance < closest_distance:
                closest_distance = distance
                closest_text = data["text"][i]

    return closest_text


# translate text using translate-shell
def translate_text(text, target_language="en"):
    try:
        result = subprocess.run(
            ["trans", f":{target_language}", text], capture_output=True, text=True
        )
        if result.returncode != 0:
            raise RuntimeError("Translation failed")
        return result.stdout.strip()
    except Exception as e:
        print(f"Error during translation: {e}")
        return None


# show translation in terminal
def show_in_term(message):
    try:
        subprocess.run(
            ["kitty", "--hold", "--class", "floatingterm", "-e", "echo", message]
        )
    except Exception as e:
        print(f"Error opening kitty terminal: {e}")


# copy text to clipboard using wl-copy
def copy_to_clipboard(text):
    try:
        subprocess.run(["wl-copy"], input=text.encode("utf-8"))
    except Exception as e:
        print(f"Error copying to clipboard: {e}")


# main function
if __name__ == "__main__":
    try:
        cursor_x, cursor_y = get_cursor_position()
        screenshot_path = take_screenshot_around_cursor(cursor_x, cursor_y)
        ocr_data = perform_ocr(screenshot_path)

        # find the closest text in the center of the screenshot
        closest_text = find_center_text(ocr_data, 200)
        print(f"Closest text: {closest_text}")

        # translate the text to english
        translated_text = translate_text(closest_text, "en")
        if translated_text:
            print(f"Translated text: {translated_text}")

            # display translation in terminal
            show_in_term(f"{closest_text} - {translated_text}")

            # copy text to clipboard
            copy_to_clipboard(f"{closest_text}")

    except Exception as e:
        print(f"Error: {e}")
