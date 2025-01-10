{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr enum bool;

  cfg = config.garden.environment;
in {
  options.garden.environment = {
    desktop = mkOption {
      type = nullOr (enum [
        "Hyprland"
        "yabai"
        "sway"
        "cosmic"
      ]);
      default = "Hyprland";
      description = "The desktop environment to be used.";
    };

    isWayland = mkOption {
      type = bool;
      default = cfg.desktop == "Hyprland" || cfg.desktop == "sway" || cfg.desktop == "cosmic";
      description = "Inferred data based on the desktop environment. True if the environment is Wayland-based.";
    };

    isWM = mkOption {
      type = bool;
      default = cfg.desktop == "Hyprland" || cfg.desktop == "sway";
      description = "Inferred data based on the desktop environment. True if the environment is a window manager.";
    };
  };
}

