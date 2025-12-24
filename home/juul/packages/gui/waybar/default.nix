{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.lists) optionals concatLists;
  inherit (lib.modules) mkIf;
  inherit (lib.hardware) monitor;
  inherit (lib.validators) hasProfile;
  inherit (osConfig.garden.programs) defaults;

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
              "custom/lyrics"
            ];
            modules-right = concatLists [
              # ["mpris"]

              (optionals (hasProfile osConfig ["laptop"]) [
                "battery"
              ])

              [
                "custom/colorpicker"
                "custom/todoist"
                "cpu"
                "memory"
                "temperature"
                "pulseaudio"
              ]

              (optionals (defaults.notifs == "swaync") [
                "custom/notification"
              ])

              [
                "tray"
                "clock"
              ]
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

    home.packages = [
      pkgs.waybar-lyric
    ];
  };
}
