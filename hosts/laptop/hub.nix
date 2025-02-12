{
  garden = {
    environment = {
      shell = "zsh";
      useHomeManager = true;

      desktop = {
        type = "Hyprland";
        hyprland = {
          useFlake = false;
        };
      };
    };

    programs = {
      cli.enable = true;
      tui.enable = true;
      gui.enable = true;
      gaming.enable = false;

      git.enable = true;
      starship.enable = true;
      aichat.enable = false;
      androidTools.enable = false;

      anki.enable = false;
      discord.enable = false;
      libreoffice.enable = false;
      brave.enable = false;
      spotify.enable = false;
      mpv.enable = true;

      imageEditor = {
        gimp.enable = false;
        pinta.enable = false;
      };

      fileManager = {
        thunar.enable = true;
        yazi.enable = true;
      };

      editor = {
        vscodium.enable = false;
        nvim.enable = true;
      };

      reading = {
        calibre.enable = false;
        zotero.enable = false;
      };

      launcher = {
        rofi.enable = true;
        tofi.enable = true;
      };

      imageViewer = {
        pqiv.enable = false;
        swayimg.enable = false;
        vimiv.enable = true;
      };

      terminal = {
        foot.enable = false;
        kitty.enable = true;
      };

      gaming = {
        steam.enable = false;
        lutris.enable = false;
        minecraft.enable = false;
      };
    };

    services = {
      syncthing = {
        enable = false;
        folders = [
          "memes"
        ];
      };

      glance.enable = false;
      kdeconnect = {
        enable = false;
        indicator.enable = false;
      };
    };
  };
}
