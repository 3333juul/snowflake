{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs;
in {
  config = mkIf cfg.libreoffice.enable {
    home.packages = [
      pkgs.libreoffice
    ];
  };
}
