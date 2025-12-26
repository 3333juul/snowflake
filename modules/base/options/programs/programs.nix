{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;
in {
  options.garden.programs = {
    anki.enable = mkEnableOption "enable anki";
    discord.enable = mkEnableOption "enable discord";
    libreoffice.enable = mkEnableOption "enable libreoffice";
    git.enable = mkEnableOption "enable git";
    starship.enable = mkEnableOption "enable starship";
    astal.enable = mkEnableOption "enable astal";
    thunderbird.enable = mkEnableOption "enable thunderbird";

    waybar.enable =
      mkEnableOption "enables waybar"
      // {default = config.garden.environment.desktop.type == "Hyprland";};

    browser = {
      brave.enable = mkEnableOption "enable brave browser";
      zen.enable = mkEnableOption "enable zen browser";
    };

    imageEditor = {
      gimp.enable = mkEnableOption "enable GIMP";
      pinta.enable = mkEnableOption "enable pinta";
    };

    fileManager = {
      thunar.enable = mkEnableOption "enable thunar";
      yazi.enable = mkEnableOption "enable yazi";
    };

    editor = {
      vscodium.enable = mkEnableOption "enable vscodium";
      neovim.enable = mkEnableOption "enable neovim";
    };

    reading = {
      calibre.enable = mkEnableOption "enable calibre";
      zotero.enable = mkEnableOption "enable zotero";
    };

    launcher = {
      rofi.enable = mkEnableOption "enable rofi";
      tofi.enable = mkEnableOption "enable tofi";
      vicinae.enable = mkEnableOption "enable vicinae";
    };

    imageViewer = {
      pqiv.enable = mkEnableOption "enable pqiv";
      swayimg.enable = mkEnableOption "enable swayimg";
      vimiv.enable = mkEnableOption "enable vimiv";
    };

    terminal = {
      foot.enable = mkEnableOption "enable foot";
      kitty.enable = mkEnableOption "enable kitty";
    };

    notes = {
      enable = mkEnableOption "enable notes";
      handwriting.enable = mkEnableOption "enable handwriting notes";
    };

    spotify = {
      enable = mkEnableOption "enable spotify";
      tui.enable = mkEnableOption "enable spotify tui client";
    };

    gaming = {
      wine.enable = mkEnableOption "enable wine";
      lutris.enable = mkEnableOption "enable lutris";
      minecraft.enable = mkEnableOption "enable minecraft";
      steam.enable = mkEnableOption "enable steam";
      gamemode.enable = mkEnableOption "enable gamemode";
    };
  };
}
