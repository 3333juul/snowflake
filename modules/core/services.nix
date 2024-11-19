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

  systemd.user.services.polkit-authentication-agent = {
    description = "PolicyKit Authentication Agent";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
      #ExecStart = "${inputs.hyprpolkitagent.packages.${pkgs.system}.hyprpolkitagent}/libexec/hyprpolkitagent";
    };
    wantedBy = ["graphical-session.target"];
  };
}
