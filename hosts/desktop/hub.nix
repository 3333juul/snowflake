{
  garden = {
    environment = {
      shell = "zsh";

      desktop = {
        type = null;

        hyprland = {
          useFlake = false;
          layout = "master";
          monitors = {
            DP-2 = "1920x1080@60,0x0,1";
            DP-3 = "1920x1080@60,1920x0,1";
            HDMI-A-1 = "1920x1080@60,3840x0,1";
          };
        };
      };
    };

    presets = {
      cli.enable = true;
      tui.enable = true;
      gui.enable = true;
      work.enable = true;
      gamingFull.enable = true;
    };

    programs = {
      git.enable = true;
      starship.enable = true;
      browser.zen.enable = true;
      editor.vscodium.enable = true;
      reading.calibre.enable = false;
    };

    services = {
      rclone.enable = true;

      syncthing = {
        enable = false;
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
