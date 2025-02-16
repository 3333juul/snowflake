let
  users = {
    scay = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjAe5xKa+1i2sXA+t+GHBzO7e5LBFwEk/3iDABEcdDW";
  };

  hosts = {
    desktop = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqz5llMjdIyVsCeqA2/mxOwAB5Xx5YRJncXbwh4g2f+";
      owner = "scay";
    };
  };

  types = with hosts; {
    servers = [];
    workstations = [
      desktop
    ];
    hybrid = [];
  };

  defAccess = list: urs: let
    listcombined = list ++ types.hybrid;
    filtered = builtins.filter (host: builtins.any (x: host.owner == x) urs) listcombined;
    keys = builtins.map (host: host.key) filtered;
  in {
    publicKeys = keys ++ map (user: users.${user}) urs;
  };

  # defAccessScay = list: defAccess list ["scay"];
  defAccessAll = list: defAccess list (builtins.attrNames users);
in {
  # test
  "secret1.age" = defAccessAll (types.workstations ++ types.servers);
}
