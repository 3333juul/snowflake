{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  inherit (config.garden.environment) useHomeManager;
  inherit (config.garden.system) mainUser;
in {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = mkIf useHomeManager {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs;};
    users.${mainUser} = {
      imports = ["${inputs.self}/home"];
      home = {
        username = mainUser;
        homeDirectory = "/home/${mainUser}";
        stateVersion = "24.05";
      };
      programs.home-manager.enable = true;
    };
  };
}
