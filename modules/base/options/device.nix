{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) bool;
in {
  options.garden = {
    device.hasBluetooth = mkOption {
      type = bool;
      default = true;
      description = "Whether or not the system has bluetooth support";
    };
  };
}
