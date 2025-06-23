{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  env = config.garden.environment;
  cfg = config.garden.programs.gaming;
in {
  config = mkIf cfg.wine.enable {
    # determine which version of wine to be used
    # then add it to systemPackages
    environment.systemPackages = let
      winePackage =
        if env.isWayland
        then pkgs.wineWowPackages.waylandFull
        else pkgs.wineWowPackages.stableFull;
    in [winePackage];
  };
}
