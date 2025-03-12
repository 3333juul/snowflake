{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;

  cfg = osConfig.garden.programs.gaming;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        gamescope
        mangohud
        winetricks
      ]
      ++ optionals cfg.lutris.enable
      [lutris];
  };
}
