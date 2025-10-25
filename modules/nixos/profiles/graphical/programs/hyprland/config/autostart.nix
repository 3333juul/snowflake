{
  lib,
  config,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (config.garden.programs) notes spotify;
  inherit (config.garden.environment.desktop.hyprland) layout plugins;
in {
  programs.hyprland.settings = {
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
        "nm-applet &"

        # Clipboard manager
        "wl-paste --watch cliphist store &"
        #"wl-clip-persist --clipboard both"

        # Pyprland
        "pypr &"

        # Cursor
        "hyprctl setcursor Bibata-Modern-Ice 24 &"

        # Scripts
        # "toggleurgent &"
        #"windowstate &"
        #"wallshift &"
      ]
      ++ optionals notes.enable [
        "[workspace 5 silent] obsidian &"
      ]
      ++ optionals spotify.enable [
        "[workspace special:music silent] spotify &"
      ]
      # ++ optionals (layout == "master") [
      #   "groupbind-run &"
      # ]
      ++ optionals (plugins.hycov.enable && plugins.hyprland-easymotion.enable) [
        "hycov-easymotion &"
      ];
  };
}
