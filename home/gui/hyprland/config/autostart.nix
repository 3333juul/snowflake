{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # System
      "poweralertd &"

      # Bar
      "waybar &"

      # Notifications
      "swaync &"

      # Systray applets
      "blueman-applet &"

      # Clipboard manager
      "wl-paste --watch cliphist store &"
      #"wl-clip-persist --clipboard both"

      # Pyprland
      "pypr &"

      # Cursor
      "hyprctl setcursor Bibata-Modern-Ice 24 &"

      # Sprawn programs
      "[workspace 5 silent] obsidian"
      "[workspace special:music silent] spotify"

      # Scripts
      "hycov-easymotion &"
      "toggleurgent &"
      "groupbind-run &"
      "selectwallpaper --last &"
      #"windowstate &"
      #"wallshift &"
    ];
  };
}
