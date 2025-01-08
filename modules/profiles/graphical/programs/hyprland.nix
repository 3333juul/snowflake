{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.hyprland = lib.mkIf (config.garden.desktop == "Hyprland") {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
