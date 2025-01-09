{lib, ...}: let
  inherit (lib) mkOption types;
  inherit (lib.types) bool enum;
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
      type = types.nullOr (
        types.enum [
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
      type = types.nullOr (
        types.enum [
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
  };
}
