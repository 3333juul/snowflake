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
    ./juul
    (mkAliasOptionModule ["hj"] ["hjem" "users" mainUser])
  ];

  hjem = {
    extraModules = [
      inputs.hjem-rum.hjemModules.default
    ];
    clobberByDefault = true;

    users.${mainUser} = {
      enable = true;
      directory = "/home/${mainUser}";
      user = mainUser;
    };
  };
}
