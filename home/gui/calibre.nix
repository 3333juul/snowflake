{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.programs.gui;
in {
  config = lib.mkIf cfg.calibre.enable {
    home.packages = with pkgs; [
      calibre
    ];
  };
}
