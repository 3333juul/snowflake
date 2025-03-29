import json
import subprocess
import sys
import math

def run_command(command):
    return subprocess.check_output(command, shell=True).decode('utf-8')

def get_window_positions_and_sizes(windows_info):
    positions_and_sizes = {}
    for window in windows_info:
        positions_and_sizes[window['address']] = {
            'pos': (window['at'][0], window['at'][1]),
            'size': (window['size'][0], window['size'][1])
        }
    return positions_and_sizes

def calculate_distance(point1, point2):
    return math.sqrt((point1[0] - point2[0])**2 + (point1[1] - point2[1])**2)

def calculate_focal_point(active_pos, active_size, direction):
    """Calculate the focal point based on direction and window size."""
    x, y = active_pos
    w, h = active_size
    if direction in ('up', 'top'):
        return (x + w / 2, y - 1)
    elif direction in ('down', 'bottom'):
        return (x + w / 2, y + h + 1)
    elif direction == 'left':
        return (x - 1, y + h / 2)
    elif direction == 'right':
        return (x + w + 1, y + h / 2)
    return None

def find_closest_window(focal_point, windows_positions, direction, active_size):
    closest_window = None
    min_distance = float('inf')
    active_width, active_height = active_size

    # Lista okien w wybranym kierunku z ich dystansami
    windows_in_direction = []

    for address, info in windows_positions.items():
        pos = info['pos']
        size = info['size']
        window_center = (pos[0] + size[0] / 2, pos[1] + size[1] / 2)

        # Sprawdzenie, czy okno znajduje się w wybranym kierunku
        if (direction == 'left' and window_center[0] < focal_point[0]) or \
           (direction == 'right' and window_center[0] > focal_point[0]) or \
           (direction == 'up' and window_center[1] < focal_point[1]) or \
           (direction == 'down' and window_center[1] > focal_point[1]):

            # Obliczenie dystansu
            distance = calculate_distance(focal_point, window_center)
            windows_in_direction.append((address, size, distance))

    # Sortowanie okien względem odległości
    windows_in_direction.sort(key=lambda x: x[2])

    # Szukanie najbliższego okna z dopasowanymi wymiarami
    for address, size, distance in windows_in_direction:
        width_match = abs(size[0] - active_width) < 10
        height_match = abs(size[1] - active_height) < 10
        is_dim_matching = width_match and height_match

        if is_dim_matching:
            closest_window = address
            break
        elif not closest_window:  # Jeśli brak dopasowania, wybierz najbliższe okno
            closest_window = address

    return closest_window

def focus_or_swap_windows(action, direction):
    workspace_info = json.loads(run_command('hyprctl -j activeworkspace'))
    workspace_id = workspace_info['id']
    windows_info = [w for w in json.loads(run_command('hyprctl -j clients')) if w['workspace']['id'] == workspace_id and w['floating']]

    if len(windows_info) < 2:
        print("Not enough windows to swap or focus.")
        exit(0)

    active_window = json.loads(run_command('hyprctl -j activewindow'))
    active_address = active_window['address']
    active_pos = (active_window['at'][0], active_window['at'][1])
    active_size = (active_window['size'][0], active_window['size'][1])

    windows_positions = get_window_positions_and_sizes(windows_info)

    focal_point = calculate_focal_point(active_pos, active_size, direction)
    if focal_point is None:
        print("Invalid direction provided.")
        exit(1)

    target_address = find_closest_window(focal_point, windows_positions, direction, active_size)
    if not target_address:
        print("No window found in the selected direction.")
        exit(0)

    if action == 'focus':
        run_command(f'hyprctl dispatch focuswindow address:{target_address}')
    elif action == 'swap':
        target_pos = windows_positions[target_address]['pos']
        target_size = windows_positions[target_address]['size']
        run_command(f'hyprctl dispatch movewindowpixel "exact {target_pos[0]} {target_pos[1]},address:{active_address}"')
        run_command(f'hyprctl dispatch movewindowpixel "exact {active_pos[0]} {active_pos[1]},address:{target_address}"')
        run_command(f'hyprctl dispatch resizewindowpixel "exact {target_size[0]} {target_size[1]},address:{active_address}"')
        run_command(f'hyprctl dispatch resizewindowpixel "exact {active_size[0]} {active_size[1]},address:{target_address}"')

if __name__ == "__main__":
    if len(sys.argv) != 3 or sys.argv[1] not in ['focus', 'swap'] or sys.argv[2] not in ['left', 'right', 'up', 'down']:
        print("Usage: python script.py [focus|swap] [left|right|up|down]")
        exit(1)
    focus_or_swap_windows(sys.argv[1], sys.argv[2])
