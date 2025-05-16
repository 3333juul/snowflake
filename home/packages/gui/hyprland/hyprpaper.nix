{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.environment;
in {
  services.hyprpaper = mkIf (cfg.isWM && cfg.isWayland) {
    enable = true;
  };
}
