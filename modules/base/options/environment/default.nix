{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.hardware) ldTernary;
  inherit (lib.options) mkOption;
  inherit (lib.types) enum bool str;

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
      default = "bash";
      description = "shell to be used";
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
