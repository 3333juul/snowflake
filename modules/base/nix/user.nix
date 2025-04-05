{
  pkgs,
  config,
  ...
}: let
  inherit (config.garden.system) mainUser;

  cfg = config.garden.environment.shell;
in {
  users.users.${mainUser} = {
    isNormalUser = true;
    description = "${mainUser}";
    extraGroups = ["nix" "wheel"];
    shell = pkgs.${cfg};

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIjAe5xKa+1i2sXA+t+GHBzO7e5LBFwEk/3iDABEcdDW"
    ];
  };
}
