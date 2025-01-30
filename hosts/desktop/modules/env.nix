{
  garden = {
    environment = {
      shell = "zsh";
      useHomeManager = true;

      desktop = {
        type = "Hyprland";
        hyprland = {
          useFlake = true;
        };
      };
    };

    programs = {
      cli.enable = true;
      tui.enable = true;
      gui.enable = true;

      git.enable = true;
      starship.enable = true;
      aichat.enable = false;
      androidTools.enable = true;

      anki.enable = true;
      discord.enable = true;
      libreoffice.enable = true;
      brave.enable = true;
      spotify.enable = true;
      mpv.enable = true;

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
        nvim.enable = true;
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
        enable = true;
        steam.enable = true;
        lutris.enable = true;
        minecraft.enable = true;
      };
    };

    services = {
      syncthing.enable = true;
      glance.enable = true;
      kdeconnect = {
        enable = true;
        indicator.enable = true;
      };
    };
  };
}
