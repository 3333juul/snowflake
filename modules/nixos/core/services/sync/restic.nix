{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.lists) optionals;
  inherit (lib.services) mkResticNotify;
  inherit (lib.helpers) filterEnabled;
  inherit (lib.validators) hasProfile;
  inherit (config.age) secrets;
  inherit (config.garden.system) mainUser;
  inherit (config.networking) hostName;
  inherit (config.garden.environment) flakePath;

  cfg = config.garden.services.restic;
  homeDir = config.users.users.${mainUser}.home;
  acceptedTypes = ["desktop" "laptop"];

  # https://github.com/NixOS/nixpkgs/issues/196547
  waitForNetwork = ''
    while ! /run/current-system/sw/bin/ping -c 1 1.0.0.1; do
      echo "Waiting for internet connection..."
      sleep 60
    done

    echo "Internet is up, backup starting."
  '';

  paths = mapAttrs (_: optionals (hasProfile config acceptedTypes)) {
    common = [
      flakePath
      "${homeDir}/documents"
      "${homeDir}/media/memes"
      "${homeDir}/media/music"
      "${homeDir}/media/pictures"
      "${homeDir}/media/videos"
      "${homeDir}/projects"
      "${homeDir}/syncthing"
      "${homeDir}/backups/hybrid"
    ];
    cloud = ["${homeDir}/backups/cloud"];
    local = ["${homeDir}/backups/local"];
  };

  # NOTE: pruneOpts module doesn't distinguish between hosts, so it's better to keep repositories per host to avoid data loss.
  # alternative: implement a custom function for this yourself.
  defPruneOpts = [
    "--keep-daily 7"
    "--keep-weekly 5"
    "--keep-monthly 12"
  ];
in {
  config = mkIf cfg.enable {
    # for cli, use: sudo restic-<name> <cmd>, e.g., sudo restic-onedrive snapshots.

    # only enable these backups that are defined in `garden.services.restic.backups`.
    services.restic.backups = filterEnabled cfg.backups {
      onedrive = {
        initialize = true;
        repository = "rclone:onedrive:Restic/${hostName}";
        passwordFile = secrets.restic-password.path;
        rcloneConfigFile = secrets.rclone.path;
        backupPrepareCommand = waitForNetwork;
        paths = paths.common ++ paths.cloud;
        pruneOpts = defPruneOpts;

        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };

      local-internal = {
        initialize = true;
        repository = "/mnt/data-hdd/restic/${hostName}";
        passwordFile = secrets.restic-password.path;
        paths = paths.common ++ paths.local;

        pruneOpts = defPruneOpts;

        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };

      local-external = {
        initialize = true;
        repository = "/run/media/${mainUser}/drive/restic/${hostName}";
        passwordFile = secrets.restic-password.path;
        paths = paths.common ++ paths.local;
        pruneOpts = defPruneOpts;
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
