{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.services.rss-bridge;
in {
  config = mkIf cfg.enable {
    services.rss-bridge = {
      enable = true;
      webserver = "nginx";
      virtualHost = "rss-bridge";

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
  };
}
