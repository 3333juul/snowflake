{
  garden = {
    environment = {
      shell = "zsh";

      desktop = {
        type = "Hyprland";

        hyprland = {
          useFlake = false;
          layout = "master";
          monitors.eDP-1 = "1920x1080@60,0x0,1.2";
        };
      };
    };

    presets = {
      cli.enable = true;
      tui.enable = true;
      gui.enable = true;
      gaming.enable = true;
    };

    programs = {
      git.enable = true;
      starship.enable = true;
      notes.enable = true;
      thunderbird.enable = true;
      reading.calibre.enable = true;

      launcher.vicinae.enable = true;
      defaults.launcher = "vicinae";
    };

    services = {
      rclone.enable = false;

      restic = {
        enable = false;
        cli.enable = true;
        backups = [
          "onedrive"
        ];
      };

      syncthing = {
        enable = true;
        folders = [
          "s21/photoroom"
          "s21/shared"
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
