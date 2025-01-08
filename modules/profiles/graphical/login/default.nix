{
  username,
  config,
  lib,
  ...
}: let
  cfg = config.garden;
in {
  services.displayManager.autoLogin = lib.mkIf cfg.autostart.enable {
    enable = true;
    user = "${username}";
  };

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
