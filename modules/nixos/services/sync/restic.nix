{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.attrsets) mapAttrs' nameValuePair;
  inherit (lib.secrets) mkSecret;
  inherit (lib.helpers) filterEnabled;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.environment) flakePath;
  inherit (config.garden) device;

  homeDir = config.users.users.${mainUser}.home;
  cfg = config.garden.services.restic;

  baseBackup = [
    "${homeDir}/documents"
    "${homeDir}/media/music"
    "${homeDir}/media/pictures"
    "${homeDir}/media/videos"
    "${homeDir}/projects"
    "${homeDir}/syncthing"
    "${flakePath}"
  ];

  # only enable these backups that are defined in garden.services.restic.backups
  filterBackups = filterEnabled cfg.backups;
in {
  config = mkIf cfg.enable {
    age.secrets = {
      restic-password = mkSecret {
        file = "restic/password";
        owner = mainUser;
        group = "users";
      };
    };

    # for cli, use: restic-<name> <cmd>, e.g., restic-onedrive snapshots
    services.restic.backups = filterBackups {
      onedrive = {
        initialize = true;
        repository = "rclone:onedrive:Restic/${config.networking.hostName}";
        passwordFile = config.age.secrets.restic-password.path;
        rcloneConfigFile = config.age.secrets.rclone.path;

        paths =
          [
            "${homeDir}/backups/cloud"
            "${homeDir}/backups/hybrid"
          ]
          ++ baseBackup;

        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
        ];

        timerConfig = null;
      };

      local = {
        initialize = true;
        repository = "/mnt/drive/restic/${config.networking.hostName}";
        passwordFile = config.age.secrets.restic-password.path;

        paths =
          [
            "${homeDir}/backups/local"
            "${homeDir}/backups/hybrid"
          ]
          ++ baseBackup;

        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
        ];

        timerConfig = null;
      };
    };

    # generate systemd services for each enabled backup defined in `services.restic.backups`.
    # if a backup fails, a desktop notification will be sent, displaying the last 5 lines of the backup log from the journal.
    # inspo: https://www.arthurkoziel.com/restic-backups-b2-nixos/
    systemd.services = let
      # create a notification service for a given backup
      mkNotifyService = name:
        nameValuePair "notify-backup-failed-${name}" {
          enable = true;
          description = "Notify on failed backup for ${name}";
          serviceConfig = {
            Type = "oneshot";
            User = mainUser;
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
    in
      mkIf (device.type != "server") (mkMerge [
        (mapAttrs' (name: _: mkNotifyService name) config.services.restic.backups)
        (mapAttrs' (name: _: mkOnFailureLink name) config.services.restic.backups)
      ]);
  };
}
