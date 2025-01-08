{lib, ...}: {
  options.garden.system = {
    virtualization.enable =
      lib.mkEnableOption "enables syncthing";
  };
}
