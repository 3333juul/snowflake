{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkAliasOptionModule;

  inherit (config.garden.environment) useHomeManager;
  inherit (config.garden.system) mainUser;
in {
  imports = [
    (mkAliasOptionModule ["hm"] ["home-manager" "users" mainUser])
  ];

  home-manager = mkIf useHomeManager {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs;};

    users.${mainUser} = {
      imports = ["${inputs.self}/home/juul"];
      programs.home-manager.enable = true;

      home = {
        username = mainUser;
        homeDirectory = "/home/${mainUser}";
        stateVersion = "24.05";
      };
    };
  };
}
