{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.system.boot;
in {
  config = mkIf (cfg.loader == "systemd-boot") {
    boot = {
      loader = {
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 10;
      };
    };
  };
}
