{
  pkgs,
  username,
  config,
  ...
}: let
  cfg = config.garden.programs.cli.shell;
in {
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.${cfg};
  };
  nix.settings.allowed-users = ["${username}"];
}
