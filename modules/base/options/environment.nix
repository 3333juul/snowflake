{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr enum bool;

  desktop = config.garden.environment.desktop.type;
in {
  options.garden.environment = {
    shell = mkOption {
      type = enum [
        "bash"
        "fish"
        "zsh"
      ];
      default = "zsh";
      description = "shell to be used";
    };

    desktop = {
      type = mkOption {
        type = nullOr (enum [
          "Hyprland"
          "yabai"
          "sway"
          "cosmic"
        ]);
        default = "Hyprland";
        description = "The desktop environment to be used.";
      };

      hyprland.useFlake = mkOption {
        type = bool;
        default = true;
        description = "Whether to use Hyprland flake";
      };
    };

    useHomeManager = mkOption {
      type = bool;
      default = true;
      description = "Whether to use home-manager";
    };

    isWayland = mkOption {
      type = bool;
      default = desktop == "Hyprland" || desktop == "sway" || desktop == "cosmic";
      description = "Inferred data based on the desktop environment. True if the environment is Wayland-based.";
    };

    isWM = mkOption {
      type = bool;
      default = desktop == "Hyprland" || desktop == "sway";
      description = "Inferred data based on the desktop environment. True if the environment is a window manager.";
    };
  };
}
