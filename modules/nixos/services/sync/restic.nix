{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.secrets) mkSecret;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.services) restic;
  inherit (builtins) elem;

  user = config.users.users.${mainUser};

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

    # # Notify when backup fails
    # systemd.services."notify-backup-failed" = {
    #   enable = true;
    #   description = "Notify on failed backup";
    #   serviceConfig = {
    #     Type = "oneshot";
    #     User = user.name;
    #   };
    #
    #   # required for notify-send
    #   environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/${
    #     toString user.uid
    #   }/bus";
    #
    #   script = ''
    #     ${pkgs.libnotify}/bin/notify-send --urgency=critical \
    #       "Backup failed" \
    #       "$(journalctl -u restic-backups-daily -n 5 -o cat)"
    #   '';
    # };
    #
    # systemd.services.restic-backups-daily.unitConfig.OnFailure = "notify-backup-failed.service";
  };
}
