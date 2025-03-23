let
  # ~/.ssh/id_ed25519.pub
  users = {
    scay = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjAe5xKa+1i2sXA+t+GHBzO7e5LBFwEk/3iDABEcdDW";
  };

  # /etc/ssh/ssh_host_ed25519_key.pub
  hosts = {
    desktop = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqz5llMjdIyVsCeqA2/mxOwAB5Xx5YRJncXbwh4g2f+";
      owner = "scay";
    };

    laptop = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7TJSH3UtTLgv2dqsXQMNMkz0DPsH9SSk5IKn5+7R4H";
      owner = "scay";
    };
  };

  types = with hosts; {
    servers = [];
    workstations = [
      desktop
      #laptop
    ];
    hybrid = [];
  };

  # generate a list of public keys for given users and hosts
  getAccess = hostList: allowedUsers: let
    # add hybrid type automatically
    listCombined = hostList ++ types.hybrid;

    # filter hosts to keep only those owned by the specified users
    relevantHosts = builtins.filter (host: builtins.any (u: host.owner == u) allowedUsers) listCombined;

    # retrieve public keys of the selected hosts
    hostKeys = builtins.map (host: host.key) relevantHosts;

    # retrieve public keys of the selected users
    userKeys = builtins.map (user: users.${user}) allowedUsers;
  in {
    publicKeys = hostKeys ++ userKeys; # return the combined list of public keys
  };

  # grant access to all users
  allAccess = hostList: getAccess hostList (builtins.attrNames users);
  # grant access only to `scay`
  #scayAccess = hostList: getAccess hostList ["scay"];
in {
  "restic/password.age" = allAccess (types.workstations ++ types.servers);
  "rclone.age" = allAccess (types.workstations ++ types.servers);
}
