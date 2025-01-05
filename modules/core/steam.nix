{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.steam = lib.mkIf config.garden.gaming.steam.enable {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };
}
