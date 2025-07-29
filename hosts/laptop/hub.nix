{
  garden = {
    environment = {
      shell = "zsh";

      desktop = {
        type = "Hyprland";

        hyprland = {
          useFlake = false;
          layout = "master";
          monitors.edP-1 = "1920x1080@60,1920x0,1.2";
        };
      };
    };

    presets = {
      cli.enable = true;
      tui.enable = true;
      gui.enable = true;
    };

    programs = {
      git.enable = true;
      starship.enable = true;
      notes.enable = true;
    };

    services = {
      rclone.enable = true;

      restic = {
        enable = true;
        cli.enable = true;
        backups = [
          "onedrive"
        ];
      };

      syncthing = {
        enable = true;
        folders = [
          "s21/photoroom"
        ];
      };

      kdeconnect = {
        enable = false;
        indicator.enable = false;
      };
    };
  };
}
