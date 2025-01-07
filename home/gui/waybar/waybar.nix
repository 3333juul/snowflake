{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.desktop;
in {
  config = lib.mkIf (cfg == "Hyprland") {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oa: {
        mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
      });
      settings = {
        mainBar = {
          position = "top";
          layer = "top";
          height = 23;
          output = ["HDMI-A-1"];
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
            #"custom/spotify"
            "mpris"
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

        topBar = {
          position = "top";
          layer = "top";
          height = 23;
          output = ["DVI-D-1"];
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
            #"custom/spotify"
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

    xdg.configFile."waybar/scripts" = {
      source = ./scripts;
      recursive = true;
    };

    xdg.configFile."waybar/style.css".source = ./style.css;
    xdg.configFile."waybar/modules.json".source = ./modules.json;
  };
}
