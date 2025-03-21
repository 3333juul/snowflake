{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;

  cfg = config.garden.system.specialisations.steamOS;
in {
  specialisation.steamOS = mkIf cfg.enable {
    configuration = {
      garden = {
        system = {
          loginManager = {
            name = mkForce "greetd";
            autoLogin.enable = mkForce true;
          };
        };

        environment.desktop.type = mkForce null;
      };

      # disable monitors defined in `garden.device.monitors`.
      # we don't want them because a tv is used as the primary display instead.
      boot.kernelParams = map (x: "video=${x}-d") (config.garden.device.monitors or []);

      programs = {
        gamescope = {
          enable = true;
          capSysNice = true;
        };

        steam = {
          enable = true;
          gamescopeSession.enable = true;
        };
      };

      services.greetd.settings = {
        initial_session = {
          command = mkForce "${pkgs.gamescope}/bin/gamescope --mangoapp -e -- ${pkgs.steam}/bin/steam -tenfoot";
        };
      };
    };
  };
}
