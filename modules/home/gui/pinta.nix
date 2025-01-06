{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.programs.gui;
in {
  config = lib.mkIf cfg.pinta.enable {
    home.packages = with pkgs; [
      pinta
    ];
  };
}
