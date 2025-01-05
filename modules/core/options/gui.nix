{lib, ...}: {
  options.garden.gui = {
    enable =
      lib.mkEnableOption "enables gui";
  };
}
