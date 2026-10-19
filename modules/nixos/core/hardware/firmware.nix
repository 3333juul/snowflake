{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  config = mkIf (config.garden.device.type != "wsl") {
    hardware.enableRedistributableFirmware = true;
  };
}
