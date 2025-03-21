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
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOanka+IERz2PBSi68hBpYKERrfVqHG6y3xzi4C49WNx";
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

  # Function to generate a list of public keys for given users and hosts
  getAccess = hostList: allowedUsers: let
    # Add hybrid type automatically
    listCombined = hostList ++ types.hybrid;

    # Filter hosts to keep only those owned by the specified users
    relevantHosts = builtins.filter (host: builtins.any (u: host.owner == u) allowedUsers) listCombined;

    # Retrieve public keys of the selected hosts
    hostKeys = builtins.map (host: host.key) relevantHosts;

    # Retrieve public keys of the selected users
    userKeys = builtins.map (user: users.${user}) allowedUsers;
  in {
    publicKeys = hostKeys ++ userKeys; # Return the combined list of public keys
  };

  # Function to grant access to all users in the system
  allAccess = hostList: getAccess hostList (builtins.attrNames users);
  # Function to grant access only to scay
  #scayAccess = hostList: getAccess hostList ["scay"];
in {
  "restic/password.age" = allAccess (types.workstations ++ types.servers);
  "rclone.age" = allAccess (types.workstations ++ types.servers);
}
