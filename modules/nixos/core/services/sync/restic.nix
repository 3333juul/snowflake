{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals concatLists;
  inherit (lib.services) mkResticNotify;
  inherit (lib.helpers) filterEnabled;
  inherit (lib.validators) hasProfile;
  inherit (config.age) secrets;
  inherit (config.garden.system) mainUser;

  homeDir = config.users.users.${mainUser}.home;
  cfg = config.garden.services.restic;

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
    # for cli, use: sudo restic-<name> <cmd>, e.g., sudo restic-onedrive snapshots.
    # only enable these backups that are defined in `garden.services.restic.backups`.
    services.restic.backups = filterEnabled cfg.backups {
      onedrive = {
        initialize = true;
        repository = "rclone:onedrive:Restic/${config.networking.hostName}";
        passwordFile = secrets.restic-password.path;
        rcloneConfigFile = secrets.rclone.path;
        backupPrepareCommand = waitForNetwork;

        paths = concatLists [
          (optionals (hasProfile config ["desktop" "laptop"])
            [
              "${homeDir}/backups/cloud"
              "${homeDir}/backups/hybrid"
            ]
            ++ cfg.basePaths)

          (optionals (hasProfile config ["server"])
            cfg.serverPaths)
        ];

        pruneOpts = cfg.defPruneOpts;

        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };

      local-external = {
        initialize = true;
        repository = "/run/media/${mainUser}/drive/restic";
        passwordFile = secrets.restic-password.path;

        paths =
          [
            "${homeDir}/backups/local"
            "${homeDir}/backups/hybrid"
          ]
          ++ cfg.basePaths;

        pruneOpts = cfg.defPruneOpts;
        timerConfig = null;
      };

      local-internal = {
        initialize = true;
        repository = "/mnt/data-hdd/restic";
        passwordFile = secrets.restic-password.path;

        paths =
          [
            "${homeDir}/backups/local"
            "${homeDir}/backups/hybrid"
          ]
          ++ cfg.basePaths;

        pruneOpts = cfg.defPruneOpts;

        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };
    };

    # update the progress once per minute.
    environment.variables = {
      RESTIC_PROGRESS_FPS = "0.016666";
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
