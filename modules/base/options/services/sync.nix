{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) listOf str;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.environment) flakePath;

  homeDir = config.users.users.${mainUser}.home;
in {
  options.garden.services = {
    rclone.enable = mkEnableOption "enable rclone";

    syncthing = {
      enable = mkEnableOption "enable syncthing";
      tray.enable = mkEnableOption "enable syncthing tray";

      folders = mkOption {
        type = listOf str;
        default = [];
        description = "list of enabled syncthing devices";
      };
    };

    restic = {
      enable = mkEnableOption "enable restic";

      backups = mkOption {
        type = listOf str;
        default = [];
        description = "list of enabled restic backups";
      };

      basePaths = mkOption {
        type = listOf str;
        default = [
          flakePath
          "${homeDir}/documents"
          "${homeDir}/media/memes"
          "${homeDir}/media/music"
          "${homeDir}/media/pictures"
          "${homeDir}/media/videos"
          "${homeDir}/projects"
          "${homeDir}/syncthing"
        ];
        description = "list of base paths to backup";
      };

      serverPaths = mkOption {
        type = listOf str;
        default = [];
        description = "list of server paths to backup";
      };

      defPruneOpts = mkOption {
        type = listOf str;
        default = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
        ];
        description = "default pruneOpts settings";
      };
    };

    kdeconnect = {
      enable = mkEnableOption "enable kdeconnect";
      indicator.enable = mkEnableOption "enable kdeconnect indicator";
    };
  };
}
