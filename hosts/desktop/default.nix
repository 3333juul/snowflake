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
      shell = "zsh";
      bat.enable = true;
      starship.enable = true;
    };

    gui = {
      enable = true;
      anki.enable = true;
      calibre.enable = true;
      gimp.enable = true;
      pinta.enable = true;
      mpv.enable = true;
      thunar.enable = true;
      zotero.enable = true;
      obs.enable = true;
      # brave.enable = true;
      # rofi.enable = true;
      # tofi.enable = true;
      # vscodium.enable = true;
      # discord.enable = true;
      # swaync.enable = true;
      # kitty.enable = true;
      # vimiv.enable = true;
    };

    gaming = {
      steam.enable = true;
    };
  };
}
