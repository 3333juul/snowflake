{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf;

  sys = config.garden.system;
  cfg = sys.virtualization;
in {
  config = mkIf (cfg.enable && (cfg.docker.enable || cfg.podman.enable)) {
    environment.systemPackages =
      [
        pkgs.podman
        pkgs.podman-compose
      ]
      ++ optionals sys.video.enable [pkgs.lxd-lts];

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
      enableNvidia = builtins.any (driver: driver == "nvidia") config.services.xserver.videoDrivers;
      autoPrune = {
        enable = true;
        flags = ["--all"];
        dates = "weekly";
      };
    };
  };
}
