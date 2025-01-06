{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.gui;
in {
  config = lib.mkIf cfg.gimp.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
