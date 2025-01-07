{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.desktop;
in {
  services.hyprpaper = lib.mkIf (cfg == "Hyprland") {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };
}
