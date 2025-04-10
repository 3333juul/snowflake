{
  garden = {
    environment = {
      useHomeManager = true;

      desktop = {
        type = null;
      };
    };

    programs = {
      cli.enable = false;
      tui.enable = false;
      gui.enable = false;

      git.enable = true;
    };

    services = {
      glance.enable = true;
      rclone.enable = true;
      tt-rss.enable = true;
      rss-bridge.enable = true;
      memos.enable = true;
      private.enable = true;

      restic = {
        enable = true;
        backups = ["onedrive"];
      };
    };
  };
}
