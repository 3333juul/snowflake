{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge mkDefault;
  inherit (config.garden.environment) isWayland;
  inherit (config.garden) presets;
in {
  config = mkMerge [
    (mkIf presets.gui.enable {
      garden.programs = {
        spotify.enable = mkDefault true;
        discord.enable = mkDefault true;
        terminal.kitty.enable = mkDefault true;
        browser.brave.enable = mkDefault true;
        imageViewer.vimiv.enable = mkDefault true;
        imageEditor.gimp.enable = mkDefault true;
        fileManager.thunar.enable = mkDefault true;

        launcher = {
          rofi.enable = mkDefault true;
          tofi.enable = mkDefault isWayland;
        };
      };
    })

    (mkIf presets.tui.enable {
      garden.programs = {
        editor.neovim.enable = mkDefault true;
        fileManager.yazi.enable = mkDefault true;
      };
    })

    (mkIf presets.work.enable {
      garden.programs = {
        notes.enable = mkDefault true;
        libreoffice.enable = mkDefault true;

        reading = {
          zotero.enable = mkDefault true;
          calibre.enable = mkDefault true;
        };
      };
    })

    (mkIf presets.gaming.enable {
      garden.programs.gaming = {
        wine.enable = mkDefault true;
        lutris.enable = mkDefault true;
        gamemode.enable = mkDefault true;
      };
    })

    (mkIf presets.gamingFull.enable {
      garden = {
        presets.gaming.enable = mkDefault true;

        programs.gaming = {
          steam.enable = mkDefault true;
          minecraft.enable = mkDefault true;
        };
      };
    })
  ];
}
