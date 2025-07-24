{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) listOf str bool;
  inherit (config.garden.services) restic;
in {
  options.garden.services = {
    rclone.enable = mkEnableOption "enable rclone";

    syncthing = {
      enable = mkEnableOption "enable syncthing";
      tray.enable = mkEnableOption "enable syncthing tray";

      overrideFolders = mkOption {
        type = bool;
        default = true;
        description = "Whether to use override folders";
      };

      overrideDevices = mkOption {
        type = bool;
        default = true;
        description = "Whether to override devices";
      };

      folders = mkOption {
        type = listOf str;
        default = [];
        description = "list of enabled syncthing devices";
      };
    };

    restic = {
      enable = mkEnableOption "enable restic";
      cli.enable = mkEnableOption "enable restic cli";

      backups = mkOption {
        type = listOf str;
        default = [];
        description = "list of enabled restic backups";
      };

      serverPaths = mkOption {
        type = listOf str;
        default = [];
        description = "list of server paths to backup";
      };
    };

    kdeconnect = {
      enable = mkEnableOption "enable kdeconnect";
      indicator.enable = mkEnableOption "enable kdeconnect indicator";
    };
  };

  config.assertions = [
    {
      assertion = restic.enable -> restic.backups != [];
      message = ''
        You've enabled Restic without specifying any backups in `garden.services.restic.backups`.
        Declare the backups you want on this specific machine.
      '';
    }
  ];
}
