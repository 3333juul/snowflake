{lib, ...}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.services) mkServiceOption;
in {
  # NOTE: remember what mkServiceOption does
  options.garden.services = {
    enable = mkEnableOption "enable services";

    minecraftServer = mkServiceOption "minecraft server" {};
    postgresql = mkServiceOption "postgresql" {};
    rss-bridge = mkServiceOption "rss-bridge" {};

    memos = mkServiceOption "memos" {
      port = 5230;
    };

    tt-rss = mkServiceOption "tt-rss" {
      port = 4124;
    };

    private = {
      enable = mkEnableOption "enable private services";

      website = mkServiceOption "private website" {
        port = 80;
      };

      glance = mkServiceOption "glance" {
        port = 5678;
      };
    };
  };
}
