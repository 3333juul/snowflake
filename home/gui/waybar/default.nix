{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.device) monitors;
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
          # Checks if the number of monitors declared in the host configuration is greater than 0.
          # If true, the first monitor from the list of monitors is assigned as the output for the main bar.
          # If false (i.e., there are no monitors declared), it assigns `null`, meaning no monitor is assigned.
          output =
            if builtins.length monitors > 0
            then builtins.elemAt monitors 0
            else null;
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

        # Enables the second bar if more than 1 monitor is defined in the host configuration
        secondBar = mkIf (builtins.length monitors > 1) {
          position = "top";
          layer = "top";
          height = 23;
          output = builtins.elemAt monitors 1; # Assigns the second monitor as the output
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
            "mpris"
            "custom/colorpicker"
            #"custom/todoist"
            "cpu"
            "memory"
            "temperature"
            "pulseaudio"
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
