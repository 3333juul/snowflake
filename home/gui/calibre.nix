{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.gui;
in {
  config = mkIf cfg.calibre.enable {
    home.packages = with pkgs; [
      calibre
    ];
  };
}
