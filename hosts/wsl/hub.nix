{
  garden = {
    environment = {
      useHomeManager = true;
      shell = "zsh";

      desktop = {
        type = null;
      };
    };

    presets = {
      cli.enable = true;
      tui.enable = true;
      gui.enable = false;
    };

    programs = {
      git.enable = true;
      starship.enable = true;
      editor.neovim.enable = true;
    };

    services = {
      rclone.enable = false;

      restic = {
        enable = false;
        cli.enable = false;
      };

      syncthing.enable = false;

      kdeconnect = {
        enable = false;
        indicator.enable = false;
      };
    };
  };
}
