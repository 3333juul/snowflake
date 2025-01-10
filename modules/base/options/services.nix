{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.garden.services = {
    enable = mkEnableOption "enables services";
    glance.enable = mkEnableOption "enables glance";
    syncthing.enable = mkEnableOption "enables syncthing";
  };
}
