{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.environment.desktop.type;
in {
  services.hyprsunset = mkIf (cfg == "Hyprland") {
    enable = true;
    transitions = {
      sunrise = {
        calendar = "*-*-* 06:00:00";
        requests = [
          ["temperature" "6500"]
          ["gamma 100"]
        ];
      };
      sunset = {
        calendar = "*-*-* 19:00:00";
        requests = [
          ["temperature" "3500"]
        ];
      };
    };
  };
}
