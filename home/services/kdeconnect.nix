{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.services.kdeconnect;
in {
  services.kdeconnect = mkIf cfg.enable {
    enable = true;
    indicator = cfg.indicator.enable;
  };
}
