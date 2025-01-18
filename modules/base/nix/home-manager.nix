{
  inputs,
  config,
  ...
}: let
  inherit (config.garden.system) mainUser;
in {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs;};
    users.${mainUser} = {
      imports = [./../../../home];
      home = {
        username = "${mainUser}";
        homeDirectory = "/home/${mainUser}";
        stateVersion = "24.05";
      };
      programs.home-manager.enable = true;
    };
  };
}
