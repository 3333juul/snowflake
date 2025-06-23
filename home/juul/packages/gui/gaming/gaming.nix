{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;

  cfg = osConfig.garden.presets.gaming;
  prg = osConfig.garden.programs.gaming;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        gamescope
        mangohud
        winetricks
      ]
      ++ optionals prg.lutris.enable
      [lutris];
  };
}
