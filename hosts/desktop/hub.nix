{
  garden = {
    environment = {
      shell = "zsh";

      desktop = {
        type = "Hyprland";

        hyprland = {
          useFlake = false;
          layout = "master";
          monitors = {
            HDMI-A-1 = "1920x1080@60,0x0,1";
            DP-3 = "1920x1080@60,1920x0,1";
          };
        };
      };
    };

    programs = {
      cli.enable = true;
      tui.enable = true;
      gui.enable = true;
      gaming.enable = true;

      git.enable = true;
      starship.enable = true;

      notes.enable = true;
      discord.enable = true;
      spotify.enable = true;
      anki.enable = true;
      libreoffice.enable = true;

      browser = {
        brave.enable = true;
        zen.enable = true;
      };

      imageEditor = {
        gimp.enable = true;
        pinta.enable = false;
      };

      fileManager = {
        thunar.enable = true;
        yazi.enable = true;
      };

      editor = {
        vscodium.enable = true;
        neovim.enable = true;
      };

      reading = {
        calibre.enable = true;
        zotero.enable = true;
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
        foot.enable = true;
        kitty.enable = true;
      };

      gaming = {
        steam.enable = true;
        lutris.enable = true;
        minecraft.enable = true;
      };
    };

    services = {
      rclone.enable = true;

      syncthing = {
        enable = true;
        tray.enable = false;
        folders = [
          "noteAir3/books"
          "noteAir3/koreader"
          "s21/shared"
          "s21/photoroom"
        ];
      };

      restic = {
        enable = true;
        backups = [
          "onedrive"
          "local-internal"
          "local-external"
        ];
      };

      kdeconnect = {
        enable = false;
        indicator.enable = false;
      };
    };
  };
}
