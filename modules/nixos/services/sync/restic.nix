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

  # create a notification service for a given backup
  mkNotifyService = name:
    nameValuePair "notify-backup-failed-${name}" {
      enable = true;
      description = "Notify on failed backup for ${name}";
      serviceConfig = {
        Type = "oneshot";
        User = user.name;
      };

      # required for notify-send to work
      environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";

      script = ''
        ${pkgs.libnotify}/bin/notify-send --urgency=critical \
          "Backup failed for ${name}" \
          "$(journalctl -u restic-backups-${name} -n 5 -o cat)"
      '';
    };

  # link a backup service to its notification service
  mkOnFailureLink = name:
    nameValuePair "restic-backups-${name}" {
      unitConfig.OnFailure = "notify-backup-failed-${name}.service";
    };

  # only enable these backups that are defined in garden.services.restic.backups
  enabledBackups = mapAttrs (name: value: mkIf (elem name restic.backups) value);
in {
  config = mkIf restic.enable {
    age.secrets = {
      restic-password = mkSecret {file = "restic/password";};
    };

    # for cli, use: sudo restic-<name> <cmd>, e.g., sudo restic-onedrive snapshots
    services.restic.backups = enabledBackups {
      onedrive = {
        initialize = true;
        repository = "rclone:onedrive:Restic/${config.networking.hostName}";
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

    # generate all systemd services
    systemd.services = mkIf (device.type != "server") (mkMerge [
      (mapAttrs' (name: _: mkNotifyService name) config.services.restic.backups)
      (mapAttrs' (name: _: mkOnFailureLink name) config.services.restic.backups)
    ]);
  };
}
