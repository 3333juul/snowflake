{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.hardware) monitor;
  inherit (osConfig.garden.device) type;

  cfg = osConfig.garden.programs;

  modules = import ./modules.nix;
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
            modules-left = [
              "hyprland/workspaces"
              "hyprland/window"
            ];
            modules-center = [
              "clock"
            ];
            modules-right = [
              "mpris"
              (mkIf (type == "laptop") "battery")
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
            modules-left = [
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
