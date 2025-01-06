{lib, ...}: {
  options.garden.gui = {
    enable =
      lib.mkEnableOption "enables gui";

    anki.enable =
      lib.mkEnableOption "enables anki";

    gimp.enable =
      lib.mkEnableOption "enables GIMP";

    pinta.enable =
      lib.mkEnableOption "enables Pinta";

    mpv.enable =
      lib.mkEnableOption "enables MPV";

    thunar.enable =
      lib.mkEnableOption "enables Thunar";

    zotero.enable =
      lib.mkEnableOption "enables Zotero";

    calibre.enable =
      lib.mkEnableOption "enables Calibre";

    obs.enable =
      lib.mkEnableOption "enables OBS";
  };
}
