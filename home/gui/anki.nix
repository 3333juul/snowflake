{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.gui;
in {
  config = mkIf cfg.anki.enable {
    home.packages = [
      pkgs.anki
    ];
  };
}
