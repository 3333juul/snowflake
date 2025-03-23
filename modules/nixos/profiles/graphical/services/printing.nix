{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.system.printing;
in {
  config = mkIf cfg.enable {
    # enable cups and some drivers for common printers
    services = {
      printing = {
        enable = true;

        drivers = builtins.attrValues {
          inherit (pkgs) gutenprint hplip;

          inherit (cfg) extraDrivers;
        };
      };

      # required for network discovery of printers
      avahi = {
        enable = true;
        nssmdns = true;
        openFirewall = true;
      };
    };
  };
}
