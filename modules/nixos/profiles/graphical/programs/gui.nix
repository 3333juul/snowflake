{
  config,
  pkgs,
  ...
}: {
  programs = {
    # we need dconf to interact with gtk
    dconf.enable = true;

    # gnome's keyring manager
    #seahorse.enable = true;

    # networkmanager tray uility
    # doesn't spawn for some reason, so i added it to hyprland autostart
    # nm-applet.enable = config.programs.waybar.enable;
  };

  # drive managmement
  environment.systemPackages = [
    pkgs.gparted
  ];

  # some programs do not apply themes when qt is managed solely through home-manager.
  # so we need to enable it also here.
  qt = {
    inherit (config.garden.style.qt) enable;
    platformTheme = "qt5ct"; # crucial
  };
}
