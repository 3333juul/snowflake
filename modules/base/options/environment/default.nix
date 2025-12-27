{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.hardware) ldTernary;
  inherit (lib.types) enum bool str;
  inherit (builtins) elem;

  sys = config.garden.system;
  env = config.garden.environment;
  desktop = env.desktop.type;
in {
  imports = [
    ./desktop.nix
  ];

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
      default = false;
      description = "Whether to use home-manager";
    };

    useHjem = mkOption {
      type = bool;
      default = false;
      description = "Whether to use hjem";
    };

    isWayland = mkOption {
      type = bool;
      default = elem desktop [
        "Hyprland"
        "dwl"
        "sway"
        "cosmic"
        "mango"
      ];
      description = "Inferred data based on the desktop environment. True if the environment is Wayland-based.";
    };

    isWM = mkOption {
      type = bool;
      default = elem desktop ["Hyprland" "dwl" "sway" "cosmic"];
      description = "Inferred data based on the desktop environment. True if the environment is a window manager.";
    };

    flakePath = mkOption {
      type = str;
      default = "/${ldTernary pkgs "home" "Users"}/${sys.mainUser}/projects/nix/snowflake";
      description = "The path to the configuration";
    };

    termFileChooser.enable = mkEnableOption "enable terminal file chooser";
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
