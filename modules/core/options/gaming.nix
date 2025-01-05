{lib, ...}: {
  options.garden.gaming = {
    steam.enable =
      lib.mkEnableOption "enables steam";

    lutris.enable =
      lib.mkEnableOption "enables lutris";

    minecraft.enable =
      lib.mkEnableOption "enable minecraft";
  };
}
