{
  lib,
  pkgs,
  osConfig,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.programs.defaults) wallDaemon;
in {
  config = mkIf (wallDaemon == "swaybg") {
    systemd.user.services.swaybg = {
      Unit = {
        Description = "swaybg wallpaper daemon";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };

      Service = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${inputs.self}/.github/assets/wallpapers/nixos/nixos.png -m fill";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    home.packages = [pkgs.swaybg];
  };
}
