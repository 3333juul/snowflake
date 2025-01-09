{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.gaming;
in {
  home.packages = with pkgs; [
    (mkIf cfg.lutris.enable lutris)
    (mkIf cfg.minecraft.enable prismlauncher)
    mangohud
    winetricks
    wineWowPackages.wayland
  ];
}
