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
  config = mkIf cfg.enable {
    # determine which version of wine to be used
    # then add it to systemPackages
    environment.systemPackages = with pkgs; let
      winePackage =
        if env.isWayland
        then wineWowPackages.waylandFull
        else wineWowPackages.stableFull;
    in [winePackage];
  };
}
