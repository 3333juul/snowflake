{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.garden.environment.desktop.hyprland) useFlake;

  cfg = config.garden.environment.desktop;
in {
  programs.hyprland = mkIf (cfg.type == "Hyprland") {
    enable = true;
    package = mkIf useFlake inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = mkIf useFlake inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
