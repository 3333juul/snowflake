{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.environment.desktop;
in {
  services.hyprpaper = mkIf (cfg == "Hyprland") {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };
}
