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
      glance.enable = cfg.glance.enable;

      website = {
        inherit (cfg.website) enable;
        scraper.enable = false;
        port = 1240;
      };
    };
  };
}
