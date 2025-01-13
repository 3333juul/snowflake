{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.environment.desktop.type;
in {
  config = mkIf (cfg == "Hyprland") {
    home.packages = with pkgs; [swaynotificationcenter];
    xdg.configFile."swaync/style.css".source = ./style.css;
    xdg.configFile."swaync/config.json".source = ./config.json;
  };
}
