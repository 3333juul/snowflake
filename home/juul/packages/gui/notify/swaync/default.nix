{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.environment) isWM;
  inherit (osConfig.garden.programs) defaults;
in {
  config = mkIf (isWM && defaults.notifs == "swaync") {
    home.packages = with pkgs; [swaynotificationcenter];
    xdg.configFile."swaync/style.css".source = ./style.css;
    xdg.configFile."swaync/config.json".source = ./config.json;
  };
}
