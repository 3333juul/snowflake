{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.programs.gui;
in {
  config = lib.mkIf cfg.anki.enable {
    home.packages = [
      pkgs.anki
    ];
  };
}
