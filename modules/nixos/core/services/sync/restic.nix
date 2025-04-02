{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.services) mkResticNotify;
  inherit (lib.secrets) mkSecret;
  inherit (lib.helpers) filterEnabled;
  inherit (lib.validators) hasProfile;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.environment) flakePath;

  homeDir = config.users.users.${mainUser}.home;
  cfg = config.garden.services.restic;

  baseBackup = [
    flakePath
    "${homeDir}/documents"
    "${homeDir}/media/music"
    "${homeDir}/media/pictures"
    "${homeDir}/media/videos"
    "${homeDir}/projects"
    "${homeDir}/syncthing"
  ];

  # https://github.com/NixOS/nixpkgs/issues/196547
  waitForNetwork = ''
    while ! /run/current-system/sw/bin/ping -c 1 1.0.0.1; do
      echo "Waiting for internet connection..."
      sleep 60
    done

    echo "Internet is up, backup starting."
  '';
in {
  config = mkIf cfg.enable {
    age.secrets = {
      restic-password = mkSecret {
        file = "restic/password";
        owner = mainUser;
        group = "users";
      };
    };

    # update the progress once per minute.
    environment.variables = {
      RESTIC_PROGRESS_FPS = "0.016666";
    };

    # for cli, use: sudo restic-<name> <cmd>, e.g., sudo restic-onedrive snapshots.
    # only enable these backups that are defined in `garden.services.restic.backups`.
    services.restic.backups = filterEnabled cfg.backups {
      onedrive = {
        initialize = true;
        repository = "rclone:onedrive:Restic/${config.networking.hostName}";
        passwordFile = config.age.secrets.restic-password.path;
        rcloneConfigFile = config.age.secrets.rclone.path;
        backupPrepareCommand = waitForNetwork;

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

        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
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
    systemd.services =
      mkIf (hasProfile config ["graphical"])
      (mkResticNotify pkgs {
        inherit (config.services.restic) backups;
        user = mainUser;
      });
  };
}
