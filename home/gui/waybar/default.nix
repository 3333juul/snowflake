{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.hardware) monitor;
  inherit (osConfig.garden.device) type;

  cfg = osConfig.garden.environment.desktop.type;
in {
  config = mkIf (cfg == "Hyprland") {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = {
        mainBar = {
          position = "top";
          layer = "top";
          height = 23;
          output = monitor 0 osConfig;
          modules-left = [
            "hyprland/workspaces"
            "hyprland/mode"
            "hyprland/scratchpad"
            "hyprland/window"
          ];
          modules-center = [
            "clock"
            #"custom/windowstate_0"
          ];
          modules-right = [
            "mpris"
            (mkIf (type == "laptop") "battery")
            "custom/colorpicker"
            #"custom/todoist"
            "cpu"
            "memory"
            "temperature"
            "pulseaudio"
            "custom/notification"
            "tray"
          ];
          include = [
            "~/.config/waybar/modules.json"
          ];
        };

        # Enables the second bar if the second monitor exists
        secondBar = mkIf (monitor 1 osConfig != null) {
          position = "top";
          layer = "top";
          height = 23;
          output = monitor 1 osConfig; # Assigns the second monitor as the output
          modules-left = [
            "hyprland/workspaces"
            "hyprland/mode"
            "hyprland/scratchpad"
            "hyprland/window"
          ];
          modules-center = [
            "clock"
            #"custom/windowstate_1"
          ];
          modules-right = [
            "tray"
          ];
          include = [
            "~/.config/waybar/modules.json"
          ];
        };
      };
    };

    xdg.configFile = {
      "waybar/scripts" = {
        source = ./scripts;
        recursive = true;
      };
      "waybar/modules.json".source = ./modules.json;
      "waybar/style.css".source = ./style.css;
    };
  };
}
