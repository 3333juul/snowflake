{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;
  inherit (osConfig.garden.device) hasTouchscreen;

  cfg = osConfig.garden.environment.desktop;
  flake = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
in {
  imports = [
    ./config/autostart.nix
    ./config/animations.nix
    ./config/keybindings.nix
    ./config/look.nix
    ./config/options.nix
    ./config/plugins.nix
    ./config/rules.nix
  ];

  config = mkIf (cfg.type == "Hyprland") {
    home.packages = with pkgs;
      [
        grimblast
        hyprpicker
        swappy
        wl-kbptr
        wlrctl
        #wl-clip-persist
      ]
      ++ optionals hasTouchscreen [iio-hyprland];

    wayland.windowManager.hyprland = {
      enable = true;
      package = mkIf cfg.hyprland.useFlake flake;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}
