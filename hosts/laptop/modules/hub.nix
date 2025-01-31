{
  garden = {
    environment = {
      desktop = {
        type = "Hyprland";
        hyprland = {
          useFlake = false;
        };
      };
      useHomeManager = true;
    };

    programs = {
      cli.enable = true;
      tui.enable = true;
      gui.enable = true;

      git.enable = true;
      starship.enable = true;
      aichat.enable = false;
      androidTools.enable = true;

      anki.enable = false;
      discord.enable = false;
      libreoffice.enable = false;
      brave.enable = true;
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
        foot.enable = true;
        kitty.enable = true;
      };

      gaming = {
        enable = false;
        steam.enable = false;
        lutris.enable = false;
        minecraft.enable = false;
      };
    };

    services = {
      syncthing.enable = false;
      glance.enable = false;
      kdeconnect = {
        enable = false;
        indicator.enable = false;
      };
    };
  };
}
