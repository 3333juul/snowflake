let
  # ~/.ssh/id_ed25519.pub
  users = {
    juul = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjAe5xKa+1i2sXA+t+GHBzO7e5LBFwEk/3iDABEcdDW";
  };

  # /etc/ssh/ssh_host_ed25519_key.pub
  hosts = {
    desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqz5llMjdIyVsCeqA2/mxOwAB5Xx5YRJncXbwh4g2f+";
    laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7TJSH3UtTLgv2dqsXQMNMkz0DPsH9SSk5IKn5+7R4H";
  };

  types = with hosts; {
    servers = [];
    workstations = [
      desktop
      laptop
    ];
    hybrid = [];
  };

  giveAccess = hostKeys: userKeys: {
    publicKeys =
      types.hybrid
      ++ hostKeys
      ++ [userKeys];
  };
in {
  "restic/password.age" = giveAccess (types.workstations ++ types.servers) users.juul;
  "rclone.age" = giveAccess (types.workstations ++ types.servers) users.juul;
  "todoist.age" = giveAccess types.workstations users.juul;
}
