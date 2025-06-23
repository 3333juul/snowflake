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
