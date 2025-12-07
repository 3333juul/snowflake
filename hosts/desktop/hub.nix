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
            DP-3 = "1920x1080@60,1920x0,1";
          };
        };
      };
    };

    presets = {
      cli.enable = true;
      tui.enable = true;
      gui.enable = true;
      work.enable = false;
      gamingFull.enable = false;
    };

    programs = {
      git.enable = true;
      starship.enable = true;
      browser.zen.enable = false;
      editor.vscodium.enable = false;
    };

    services = {
      rclone.enable = true;

      syncthing = {
        enable = true;
        tray.enable = false;
        folders = [
          # "noteAir3/books"
          # "noteAir3/koreader"
          # "s21/shared"
          # "s21/photoroom"
          "memes"
        ];
      };

      restic = {
        enable = false;
        cli.enable = true;
        backups = [
          # "onedrive"
          # "local-internal"
          # "local-external"
        ];
      };

      kdeconnect = {
        enable = false;
        indicator.enable = false;
      };
    };
  };
}
