{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf;
  inherit (lib.hardware) monitor;
  inherit (lib.validators) hasProfile;

  cfg = osConfig.garden.programs;
  modules = import ./modules.nix;
  desktop = osConfig.garden.environment.desktop.type;
in {
  imports = [./scripts];

  config = mkIf cfg.waybar.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      style = ./style.css;
      settings = {
        mainBar =
          {
            position = "top";
            layer = "top";
            height = 23;
            output = monitor osConfig 0;
            modules-left = optionals (desktop == "Hyprland") [
              "hyprland/workspaces"
              "hyprland/window"
            ];
            modules-center = [
              "clock"
            ];
            modules-right = [
              "mpris"
              (mkIf (hasProfile osConfig ["laptop"]) "battery")
              "custom/colorpicker"
              "custom/todoist"
              "cpu"
              "memory"
              "temperature"
              "pulseaudio"
              "custom/notification"
              "tray"
            ];
          }
          // modules;

        # enable the second bar if the second monitor exists
        secondBar = mkIf (monitor osConfig 1 != null) ({
            position = "top";
            layer = "top";
            height = 23;
            output = monitor osConfig 1; # assign the second monitor as the output
            modules-left = optionals (desktop == "Hyprland") [
              "hyprland/workspaces"
              "hyprland/window"
            ];
            modules-center = [
              "clock"
            ];
            modules-right = [
              "tray"
            ];
          }
          // modules);
      };
    };
  };
}
