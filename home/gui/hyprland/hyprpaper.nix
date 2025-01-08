{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.environment.desktop;
in {
  services.hyprpaper = lib.mkIf (cfg == "Hyprland") {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };
}
