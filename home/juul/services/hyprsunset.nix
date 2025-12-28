{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.environment.desktop.type;
in {
  services.hyprsunset = mkIf (cfg == "Hyprland") {
    enable = false;
    # TODO:
  };
}
