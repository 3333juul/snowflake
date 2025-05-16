{lib, ...}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) nullOr enum bool listOf str;
in {
  options.garden.environment = {
    desktop = {
      type = mkOption {
        type = nullOr (enum [
          "Hyprland"
          "yabai"
          "sway"
          "cosmic"
          "dwl"
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

        plugins = {
          hycov.enable = mkEnableOption {} // {default = false;};
          hyprNStack.enable = mkEnableOption {} // {default = false;};
          hyprgrass.enable = mkEnableOption {} // {default = false;};
          hyprland-easymotion.enable = mkEnableOption {} // {default = false;};
        };
      };
    };
  };
}
