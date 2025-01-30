{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.gaming;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (mkIf cfg.lutris.enable lutris)
      mangohud
      winetricks
    ];
  };
}
