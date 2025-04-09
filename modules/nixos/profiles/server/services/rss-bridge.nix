{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.helpers) addBackupPaths;

  cfg = config.garden.services.rss-bridge;
  dataDir = "/var/lib/rss-bridge";
in {
  config = mkIf cfg.enable {
    services = {
      rss-bridge = {
        enable = true;
        webserver = "nginx";
        virtualHost = "rss-bridge";
        inherit dataDir;

        config = {
          system.enabled_bridges = ["*"];

          error = {
            output = "http";
            report_limit = 5;
          };

          FileCache = {
            enable_purge = true;
          };
        };
      };

      restic.backups = addBackupPaths config ["*"] [dataDir];
    };
  };
}
