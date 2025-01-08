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
}
