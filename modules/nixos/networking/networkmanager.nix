{
  pkgs,
  host,
  config,
  lib,
  ...
}: let
  inherit (lib.lists) optionals;

  cfg = config.garden.programs;
in {
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
  };

  environment.systemPackages = optionals cfg.gui.enable [
    pkgs.networkmanagerapplet
  ];
}
