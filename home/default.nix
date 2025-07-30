{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkAliasOptionModule;
  inherit (config.garden.system) mainUser;
in {
  imports = [
    (mkAliasOptionModule ["hm"] ["home-manager" "users" mainUser])
    ./mixins
  ];

  home-manager = {
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
