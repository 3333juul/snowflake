{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (config.garden.system) mainUser;

  cfg = config.garden.programs;
in {
  networking = {
    networkmanager.enable = true;
  };

  environment.systemPackages = optionals cfg.gui.enable [
    pkgs.networkmanagerapplet
  ];

  users.users.${mainUser}.extraGroups = ["networkmanager"];
}
