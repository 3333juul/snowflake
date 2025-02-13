{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.garden.system) mainUser;

  cfg = config.garden.services;
in {
  config = mkIf cfg.restic.enable {
    # agenix
    # TODO:

    # ssh known hosts
    programs.ssh.knownHosts = {
    };

    # TODO:
    services.restic.backups = {
      daily = {
        initialize = true;
        paths = [
          # what to backup
        ];
        passwordFile = ""; # encryption
        repository = "";

        extraOptions = [
          # how to connect
        ];
        timerConfig = {
          # when to backup
          OnCalendar = "00:05";
          RandomizedDelaySec = "5h";
        };
      };
    };

    systemd.services.restic-backups-daily.unitConfig.OnFailure = "notify-backup-failed.service";

    systemd.services."notify-backup-failed" = {
      enable = true;
      description = "Notify on failed backup";
      serviceConfig = {
        Type = "oneshot";
        User = config.users.users.${mainUser}.name;
      };

      # required for notify-send
      environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/${
        toString config.users.users.${mainUser}.uid
      }/bus";

      script = ''
        ${pkgs.libnotify}/bin/notify-send --urgency=critical \
          "Backup failed" \
          "$(journalctl -u restic-backups-daily -n 5 -o cat)"
      '';
    };
  };
}
