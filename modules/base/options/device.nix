{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) listOf str nullOr enum bool;
in {
  options.garden.device = {
    type = mkOption {
      type = nullOr (
        enum [
          "laptop"
          "desktop"
          "server"
          "hybrid"
          "wsl"
          "lite"
          "vm"
        ]
      );
      default = null;
    };

    profiles = mkOption {
      type = listOf (enum [
        # physical
        "laptop"
        "desktop"
        "server"
        "wsl"
        "vm"

        # meta
        "graphical"
        "headless"
        "iso"
      ]);
      default = [];
      description = ''
        Profiles for different system types.
        They're declared in `hosts/default.nix`
        and automatically added to the module system by the `lib.builders.mkHost` function
      '';
    };

    gpu = mkOption {
      type = nullOr (
        enum [
          "amd"
          "intel"
          "nvidia"
          "hybrid-nv"
        ]
      );
      default = null;
      description = "The manufacturer of the primary system gpu";
    };

    cpu = mkOption {
      type = nullOr (
        enum [
          "intel"
          "vm-intel"
          "amd"
          "vm-amd"
        ]
      );
      default = null;
      description = "The manufacturer of the primary system cpu";
    };

    hasBluetooth = mkOption {
      type = bool;
      default = true;
      description = "Whether or not the system has bluetooth support";
    };

    hasSound = mkOption {
      type = bool;
      default = true;
      description = "Whether the system has sound support (usually true except for servers)";
    };

    hasTPM = mkOption {
      type = bool;
      default = false;
      description = "Whether the system has tpm support";
    };

    hasTouchscreen = mkOption {
      type = bool;
      default = false;
      description = "Whether the system has touchscreen support";
    };

    monitors = mkOption {
      type = listOf str;
      default = [];
      description = "Declare host's monitors";
    };

    keyboard = mkOption {
      type = enum [
        "us"
        "gb"
        "pl"
      ];
      default = "pl";
    };
  };
}
