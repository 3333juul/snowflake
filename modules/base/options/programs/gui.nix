{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.garden.programs.gui = {
    enable = mkEnableOption "enables gui";

    anki.enable = mkEnableOption "enables anki";
    brave.enable = mkEnableOption "enables brave";
    calibre.enable = mkEnableOption "enables calibre";
    discord.enable = mkEnableOption "enables discord";
    gimp.enable = mkEnableOption "enables GIMP";
    libreoffice.enable = mkEnableOption "enables libreoffice";
    mpv.enable = mkEnableOption "enables MPV";
    pinta.enable = mkEnableOption "enables pinta";
    rofi.enable = mkEnableOption "enables rofi";
    spotify.enable = mkEnableOption "enables spotify";
    thunar.enable = mkEnableOption "enables thunar";
    tofi.enable = mkEnableOption "enables tofi";
    vscodium.enable = mkEnableOption "enables vscodium";
    zotero.enable = mkEnableOption "enables zotero";

    imageViewer = {
      pqiv.enable = mkEnableOption "enables pqiv";
      swayimg.enable = mkEnableOption "enables swayimg";
      vimiv.enable = mkEnableOption "enables vimiv";
    };

    terminal = {
      foot.enable = mkEnableOption "enables foot";
      kitty.enable = mkEnableOption "enables kitty";
    };
  };
}
