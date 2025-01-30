{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.garden.programs = {
    anki.enable = mkEnableOption "enables anki";
    discord.enable = mkEnableOption "enables discord";
    libreoffice.enable = mkEnableOption "enables libreoffice";
    brave.enable = mkEnableOption "enables brave";
    spotify.enable = mkEnableOption "enables spotify";
    mpv.enable = mkEnableOption "enables MPV";
    aichat.enable = mkEnableOption "enables aichat";
    androidTools.enable = mkEnableOption "enables android tools";
    git.enable = mkEnableOption "enables git";
    starship.enable = mkEnableOption "enables starship";

    imageEditor = {
      gimp.enable = mkEnableOption "enables GIMP";
      pinta.enable = mkEnableOption "enables pinta";
    };

    fileManager = {
      thunar.enable = mkEnableOption "enables thunar";
      yazi.enable = mkEnableOption "enables yazi";
    };

    editor = {
      vscodium.enable = mkEnableOption "enables vscodium";
      nvim.enable = mkEnableOption "enables nvim";
    };

    reading = {
      calibre.enable = mkEnableOption "enables calibre";
      zotero.enable = mkEnableOption "enables zotero";
    };

    launcher = {
      rofi.enable = mkEnableOption "enables rofi";
      tofi.enable = mkEnableOption "enables tofi";
    };

    imageViewer = {
      pqiv.enable = mkEnableOption "enables pqiv";
      swayimg.enable = mkEnableOption "enables swayimg";
      vimiv.enable = mkEnableOption "enables vimiv";
    };

    terminal = {
      foot.enable = mkEnableOption "enables foot";
      kitty.enable = mkEnableOption "enables kitty";
    };

    gaming = {
      gaming.enable = mkEnableOption "Enable gaming programs";
      lutris.enable = mkEnableOption "enables lutris";
      minecraft.enable = mkEnableOption "enable minecraft";
      steam.enable = mkEnableOption "enables steam";
    };
  };
}
