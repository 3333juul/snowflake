{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.steam = lib.mkIf config.garden.programs.gaming.steam.enable {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };
}
