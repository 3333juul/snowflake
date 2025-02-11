{lib, ...}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.types) listOf str;
in {
  options.garden.services = {
    enable = mkEnableOption "enable services";
    glance.enable = mkEnableOption "enable glance";

    syncthing = {
      enable = mkEnableOption "enable syncthing";

      enabledDevices = lib.mkOption {
        type = listOf str;
        default = [];
        description = "list of enabled syncthing devices";
      };

      enabledFolders = lib.mkOption {
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
