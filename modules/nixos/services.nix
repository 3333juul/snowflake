{
  pkgs,
  username,
  ...
}: {
  systemd.services.glance = {
    serviceConfig = {
      Restart = "always";
      ExecStart = "${pkgs.glance}/bin/glance --config=/home/${username}/.config/glance/glance.yml";
    };
  };

  # discard blocks that are not in use by the filesystem, good for SSDs health
  services.fstrim.enable = true;
}
