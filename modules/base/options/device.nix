{lib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) listOf str nullOr enum bool;
in {
  options.garden.device = {
    type = mkOption {
      type = enum [
        "laptop"
        "desktop"
        "server"
        "hybrid"
        "wsl"
        "lite"
        "vm"
      ];
      default = "";
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
