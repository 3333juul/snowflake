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
      rclone.enable = true;
      tt-rss.enable = true;
      rss-bridge.enable = true;
      memos.enable = true;
      minecraftServer.enable = false;

      private = {
        enable = true;
        glance = true;
        website = false;
      };

      restic = {
        enable = true;
        backups = ["onedrive"];
      };
    };
  };
}
