{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.services.private;
in {
  imports = [inputs.private-repo.nixosModules.default];

  config = mkIf cfg.enable {
    services.private = {
      enable = true;

      website = {
        enable = true;
        port = 1240;
      };

      scraper.enable = true;
    };
  };
}
