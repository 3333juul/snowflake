{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;

  cfg = config.garden.system.specialisations;
in {
  specialisation.hybrid-server = mkIf (cfg.enable && cfg.hybrid.server.enable) {
    configuration = {
      garden = {
        system.security.tor.enable = mkForce true;
        environment.desktop.type = mkForce null;

        networking.tailscale = {
          enable = mkForce true;
          isServer = mkForce true;
          isClient = mkForce false;
        };

        services = {
          tt-rss.enable = mkForce true;

          private = {
            enable = mkForce true;
            website.enable = mkForce true;
          };
        };
      };
    };
  };
}
