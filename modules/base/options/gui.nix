{lib, ...}: {
  options.garden.programs.gui = {
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

    discord.enable =
      lib.mkEnableOption "enables discord";

    brave.enable =
      lib.mkEnableOption "enables brave";

    rofi.enable =
      lib.mkEnableOption "enables rofi";

    tofi.enable =
      lib.mkEnableOption "enables tofi";

    vscodium.enable =
      lib.mkEnableOption "enables vscodium";

    terminal = {
      kitty.enable =
        lib.mkEnableOption "enables kitty";
      foot.enable =
        lib.mkEnableOption "enables foot";
    };

    image = {
      vimiv.enable =
        lib.mkEnableOption "enables vimiv";

      pqiv.enable =
        lib.mkEnableOption "enables pqiv";

      swayimg.enable =
        lib.mkEnableOption "enables swayimg";
    };
  };
}
