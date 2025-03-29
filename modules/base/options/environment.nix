{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.hardware) ldTernary;
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr enum bool listOf str;

  sys = config.garden.system;
  env = config.garden.environment;
  desktop = env.desktop.type;
in {
  options.garden.environment = {
    shell = mkOption {
      type = enum [
        "bash"
        "fish"
        "zsh"
        "nushell"
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
        default = null;
        description = "The desktop environment to be used.";
      };

      hyprland = {
        useFlake = mkOption {
          type = bool;
          default = true;
          description = "Whether to use Hyprland flake";
        };

        monitors = mkOption {
          type = listOf str;
          default = [];
          description = "List of monitor configurations for Hyprland.";
        };

        layout = mkOption {
          type = enum [
            "master"
            "dwindle"
          ];
          default = "master";
          description = "List of available layouts for Hyprland.";
        };
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

    flakePath = mkOption {
      type = str;
      default = "/${ldTernary pkgs "home" "Users"}/${sys.mainUser}/snowflake";
      description = "The path to the configuration";
    };
  };

  config.assertions = [
    {
      assertion = env.useHomeManager -> sys.mainUser != null;
      message = "system.mainUser must be set while useHomeManager is enabled";
    }
    {
      assertion = env.flakePath != null -> sys.mainUser != null;
      message = "system.mainUser must be set if a flakePath is specified";
    }
  ];
}
