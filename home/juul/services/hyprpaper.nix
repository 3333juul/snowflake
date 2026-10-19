{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.environment) isWM;
  inherit (osConfig.garden.programs.defaults) wallDaemon;
in {
  services.hyprpaper = mkIf (isWM && wallDaemon == "hyprpaper") {
    enable = true;
  };
}
