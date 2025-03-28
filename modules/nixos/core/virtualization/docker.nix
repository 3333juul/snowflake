{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.lists) optionals concatLists;
  inherit (lib.modules) mkIf;

  sys = config.garden.system;
  cfg = sys.virtualization;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = concatLists [
      (optionals cfg.docker.enable [
        pkgs.podman
        pkgs.podman-compose
      ])

      (optionals (cfg.docker.enable && sys.video.enable) [pkgs.lxd-lts])
    ];

    virtualisation.podman = mkIf (cfg.docker.enable || cfg.podman.enable) {
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
