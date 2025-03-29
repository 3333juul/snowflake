import json
import subprocess
import math
import sys


def run_command(command):
    return subprocess.check_output(command, shell=True).decode('utf-8')


def arrange_windows(orientation):
    # Margins
    outer_margin = 100
    inner_margin = 18

    # Fetch information about the active workspace
    workspace_info = json.loads(run_command('hyprctl -j activeworkspace'))
    workspace_id = workspace_info['id']

    # Fetch information about the monitor
    monitor_info = [
        m for m in json.loads(run_command('hyprctl -j monitors'))
        if m['focused']
    ][0]
    monitor_width = monitor_info['width'] - 2 * outer_margin
    monitor_height = monitor_info['height'] - 2 * outer_margin

    # Fetch information about the windows
    windows_info = [
        w for w in json.loads(run_command('hyprctl -j clients'))
        if w['workspace']['id'] == workspace_id and w['floating']
    ]

    # Calculate the number of windows
    windows_count = len(windows_info)

    # If there are no windows, terminate the script
    if windows_count == 0:
        print("Brak okien do ułożenia.")
        exit(0)

    # Calculate window dimensions
    if orientation == 'vertical' and windows_count == 2:
        rows = 1
    # elif orientation == 'horizontal' and windows_count == 2:
    #    rows = 2
    else:
        rows = (
            math.ceil(math.sqrt(windows_count))
            if orientation == 'vertical'
            else math.ceil(windows_count / math.ceil(math.sqrt(windows_count)))
        )
    cols = math.ceil(windows_count / rows)
    window_width = (monitor_width - (cols - 1) * inner_margin) // cols
    window_height = (monitor_height - (rows - 1) * inner_margin) // rows

    # Variables to store the current position
    current_x = outer_margin
    current_y = outer_margin

    # Iterate over the windows
    for i, window in enumerate(windows_info):
        window_address = window['address']

        # Check if we are in the last row and if it's full
        if (orientation == 'horizontal' and (i // cols + 1) == rows
                and windows_count % cols != 0):
            window_width = (monitor_width - (windows_count % cols - 1)
                            * inner_margin) // (windows_count % cols)

        elif (orientation == 'vertical' and (i // rows + 1) == cols
                and windows_count % rows != 0):
            window_height = (monitor_height - (windows_count % rows - 1)
                             * inner_margin) // (windows_count % rows)

        # Resize the window
        run_command(
            f'hyprctl dispatch resizewindowpixel "exact {window_width} '
            f'{window_height},address:{window_address}"'
        )

        # Move the window
        run_command(
            f'hyprctl dispatch movewindowpixel "exact {current_x} '
            f'{current_y},address:{window_address}"'
        )

        # Update position for the next window
        if orientation == 'horizontal':
            current_x += window_width + inner_margin
            if (i + 1) % cols == 0:
                current_x = outer_margin
                current_y += window_height + inner_margin
        else:
            current_y += window_height + inner_margin
            if (i + 1) % rows == 0:
                current_y = outer_margin
                current_x += window_width + inner_margin


if __name__ == "__main__":
    if len(sys.argv) != 2 or sys.argv[1] not in ['horizontal', 'vertical']:
        print("Usage: python script.py [horizontal|vertical]")
        exit(1)
    arrange_windows(sys.argv[1])
