{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.programs.defaults) wallDaemon;
in {
  services.hyprpaper = mkIf (wallDaemon == "hyprpaper") {
    enable = true;
  };
}
