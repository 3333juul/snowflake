{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (osConfig.garden.programs) notes spotify;
  inherit (osConfig.garden.environment.desktop.hyprland) layout;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once =
      [
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

        # Scripts
        "hycov-easymotion &"
        "toggleurgent &"
        "selectwallpaper --last &"
        #"windowstate &"
        #"wallshift &"
      ]
      ++ optionals (layout == "master") [
        "groupbind-run &"
      ]
      ++ optionals notes.enable [
        "[workspace 5 silent] obsidian &"
      ]
      ++ optionals spotify.enable [
        "[workspace special:music silent] spotify &"
      ];
  };
}
