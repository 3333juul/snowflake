{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf;

  sys = config.garden.system;
  cfg = sys.virtualization;
in {
  config = mkIf (cfg.enable && cfg.distrobox.enable) {
    environment.systemPackages = [
      pkgs.distrobox
    ];

    systemd.user = {
      timers."distrobox-update" = {
        enable = true;
        wantedBy = ["timers.target"];
        timerConfig = {
          OnBootSec = "1h";
          OnUnitActiveSec = "1d";
          Unit = "distrobox-update.service";
        };
      };

      services."distrobox-update" = {
        enable = true;
        script = ''
          ${getExe pkgs.distrobox} upgrade --all
        '';
        serviceConfig = {
          Type = "oneshot";
        };
      };
    };
  };
}
