{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.gui;
in {
  config = mkIf cfg.gimp.enable {
    home.packages = with pkgs; [
      gimp
    ];
  };
}
