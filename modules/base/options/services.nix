{lib, ...}: {
  options.garden.services = {
    syncthing.enable =
      lib.mkEnableOption "enables syncthing";

    glance.enable =
      lib.mkEnableOption "enables glance";
  };
}
