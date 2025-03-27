{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkForce;
  inherit (builtins) listToAttrs;

  cfg = config.garden.system.specialisations;
in {
  specialisation.steamOS = mkIf (cfg.enable && cfg.steamOS.enable) {
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
      # https://nixos.org/manual/nixos/stable/#module-hardware-display-modes
      hardware.display.outputs = listToAttrs (map (monitor: {
          name = monitor;
          value = {mode = "d";};
        })
        config.garden.device.monitors);

      programs = {
        gamescope = {
          enable = mkForce true;
          capSysNice = mkForce true;
        };

        steam = {
          enable = mkForce true;
          gamescopeSession.enable = mkForce true;
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
