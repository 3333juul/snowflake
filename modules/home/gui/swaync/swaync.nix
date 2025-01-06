{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.desktop;
in {
  config = lib.mkIf (cfg == "Hyprland") {
    home.packages = with pkgs; [swaynotificationcenter];
    xdg.configFile."swaync/style.css".source = ./style.css;
    xdg.configFile."swaync/config.json".source = ./config.json;
  };
}

