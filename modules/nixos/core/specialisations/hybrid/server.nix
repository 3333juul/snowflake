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
        environment.desktop.type = mkForce null;

        system = {
          security.tor.enable = mkForce true;
          loginManager.name = mkForce "none";

          networking.tailscale = {
            enable = mkForce true;
            isServer = mkForce true;
            isClient = mkForce false;
          };
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
