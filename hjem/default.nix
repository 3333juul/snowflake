{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf mkAliasOptionModule;

  inherit (config.garden.environment) useHjem;
  inherit (config.garden.system) mainUser;
in {
  imports = [
    ./juul
    (mkAliasOptionModule ["hj"] ["hjem" "users" mainUser])
  ];

  hjem = mkIf useHjem {
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
