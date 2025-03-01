{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.attrsets) mapAttrs mapAttrs' nameValuePair;
  inherit (lib.secrets) mkSecret;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.services) restic;
  inherit (config.garden) device;
  inherit (builtins) elem;

  user = config.users.users.${mainUser};

  # Create a notification service for a given backup
  mkNotifyService = backupName:
    nameValuePair "notify-backup-failed-${backupName}" {
      enable = true;
      description = "Notify on failed backup for ${backupName}";
      serviceConfig = {
        Type = "oneshot";
        User = user.name;
      };

      # required for notify-send to work
      environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";

      script = ''
        ${pkgs.libnotify}/bin/notify-send --urgency=critical \
          "Backup failed for ${backupName}" \
          "$(journalctl -u restic-backups-${backupName} -n 5 -o cat)"
      '';
    };

  # Link a backup service to its notification service
  mkOnFailureLink = backupName:
    nameValuePair "restic-backups-${backupName}" {
      unitConfig.OnFailure = "notify-backup-failed-${backupName}.service";
    };

  # only enable these backups that are defined in garden.services.restic.backups
  enabledBackups = mapAttrs (name: value: mkIf (elem name restic.backups) value);
in {
  config = mkIf restic.enable {
    age.secrets = {
      restic-password = mkSecret {file = "restic/password";};
      rclone = mkSecret {file = "rclone";};
    };

    services.restic.backups = enabledBackups {
      onedrive = {
        initialize = true;
        repository = "rclone:onedrive:backups/${config.networking.hostName}";
        passwordFile = config.age.secrets.restic-password.path;
        rcloneConfigFile = config.age.secrets.rclone.path;

        paths = [
          "${user.home}/media"
        ];

        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
        ];
      };
    };

    # Generate all systemd services
    systemd.services = mkIf (device.type != "server") (mkMerge [
      (mapAttrs' (name: _: mkNotifyService name) config.services.restic.backups)
      (mapAttrs' (name: _: mkOnFailureLink name) config.services.restic.backups)
    ]);
  };
}
