{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.services.private;
in {
  imports = [inputs.nix-private.nixosModules.default];

  config = mkIf cfg.enable {
    services.private = {
      enable = true;

      glance = {
        inherit (cfg.glance) enable;
        inherit (cfg.glance) port;
      };

      website = {
        inherit (cfg.website) enable;
        inherit (cfg.website) port;
        scraper.enable = true;
      };
    };
  };
}
