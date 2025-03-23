{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) listOf str;
in {
  options.garden.services = {
    enable = mkEnableOption "enable services";
    glance.enable = mkEnableOption "enable glance";
    minecraftServer.enable = mkEnableOption "enable minecraft server";
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
    };

    kdeconnect = {
      enable = mkEnableOption "enable kdeconnect";
      indicator.enable = mkEnableOption "enable kdeconnect indicator";
    };
  };
}
