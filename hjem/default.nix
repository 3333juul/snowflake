{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  inherit (config.garden.environment) useHjem;
  inherit (config.garden.system) mainUser;
in {
  hjem = mkIf useHjem {
    extraModules = [
      ./juul
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
