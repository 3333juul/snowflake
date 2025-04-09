{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  imports = [./sync.nix];

  options.garden.services = {
    enable = mkEnableOption "enable services";

    postgresql = mkEnableOption "enable postgresql";
    private.enable = mkEnableOption "enable private services";
    glance.enable = mkEnableOption "enable glance";
    minecraftServer.enable = mkEnableOption "enable minecraft server";
    memos.enable = mkEnableOption "enable memos";
    tt-rss.enable = mkEnableOption "enable tt-rss";
    rss-bridge.enable = mkEnableOption "enable rss-bridge";
  };
}
