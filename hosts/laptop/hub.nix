{
  garden = {
    environment = {
      shell = "zsh";
      useHomeManager = true;

      desktop = {
        type = "Hyprland";

        hyprland = {
          useFlake = false;
          layout = "master";
          monitors.edP-1 = "1920x1080@60,1920x0,1.2";
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

      notes.enable = false;
      anki.enable = false;
      discord.enable = false;
      libreoffice.enable = false;
      spotify.enable = false;

      browser = {
        brave.enable = true;
        zen.enable = false;
      };

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
        neovim.enable = true;
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
      restic.enable = false;

      syncthing = {
        enable = false;
        folders = [
          "memes"
        ];
      };

      kdeconnect = {
        enable = false;
        indicator.enable = false;
      };
    };
  };
}
