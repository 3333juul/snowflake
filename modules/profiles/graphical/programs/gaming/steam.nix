{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.programs.gaming;
in {
  programs.steam = mkIf cfg.steam.enable {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };
}
