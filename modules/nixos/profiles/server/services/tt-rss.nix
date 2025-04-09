{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.services.tt-rss;

  # fix theme: https://github.com/levito/tt-rss-feedly-theme/issues/122
  themeFeedly = pkgs.tt-rss-theme-feedly.overrideAttrs {
    src = pkgs.fetchFromGitHub {
      owner = "levito";
      repo = "tt-rss-feedly-theme";
      rev = "dist";
      sha256 = "sha256-0U2APDh++U7qWwv9ky9nEZ8WvsSbWBTSUwqQqkIkaqU=";
    };
  };
in {
  config = mkIf cfg.enable {
    services = {
      tt-rss = {
        enable = true;
        selfUrlPath = "http://localhost";
        virtualHost = "tt-rss";
        themePackages = [themeFeedly];

        database = {
          type = "pgsql";
        };
      };

      nginx = {
        enable = true;

        virtualHosts."${config.services.tt-rss.virtualHost}" = {
          listen = [
            {
              port = 4124;
              addr = "0.0.0.0";
            }
          ];
        };
      };
    };
  };
}
