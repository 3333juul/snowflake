{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.desktop-environment;
in {
  home.packages = with pkgs; [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    hyprpicker
    grim
    slurp
    wf-recorder
    glib
    wayland
    direnv
    swappy
    wl-kbptr
    wlrctl
    #wl-clip-persist
  ];

  imports = [
    ./config/autostart.nix
    ./config/decorations.nix
    ./config/animations.nix
    ./config/keybindings.nix
    ./config/options.nix
    ./config/plugins.nix
    ./config/rules.nix
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };
}
