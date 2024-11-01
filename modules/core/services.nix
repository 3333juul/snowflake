{
  pkgs,
  username,
  ...
}: {
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
  };
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';
  systemd.services.glance = {
    serviceConfig = {
      Restart = "always";
      ExecStart = "${pkgs.glance}/bin/glance --config=/home/${username}/.config/glance/glance.yml";
    };
  };
}
