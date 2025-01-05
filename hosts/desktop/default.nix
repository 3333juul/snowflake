{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules/core
  ];

  powerManagement.cpuFreqGovernor = "performance";

  garden = {
    desktop-environment = "Hyprland";
    cli = {
      bat.enable = true;
      starship.enable = true;
    };
    gaming = {
      steam.enable = true;
    };
  };
}
