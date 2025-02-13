{lib, ...}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.types) listOf str;
in {
  options.garden.services = {
    enable = mkEnableOption "enable services";
    glance.enable = mkEnableOption "enable glance";
    restic.enable = mkEnableOption "enable restic";
    minecraftServer.enable = mkEnableOption "enable minecraft server";

    syncthing = {
      enable = mkEnableOption "enable syncthing";

      folders = lib.mkOption {
        type = listOf str;
        default = [];
        description = "list of enabled syncthing devices";
      };
    };

    kdeconnect = {
      enable = mkEnableOption "enable kdeconnect";
      indicator.enable = mkEnableOption "enable kdeconnect indicator";
    };
  };
}
