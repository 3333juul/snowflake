{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.services.kdeconnect;
  pkg = config.programs.kdeconnect.package;
in {
  config = mkIf cfg.enable {
    programs.kdeconnect = {
      enable = true;
      # default package is `pkgs.plasma5Packages.kdeconnect-kde`.
      # `pkgs.kdePackages.kdeconnect-kde` - this installs kwallet so we want to avoid that.
    };

    # tray service
    systemd.user.services = mkIf cfg.indicator.enable {
      kdeconnect-indicator = {
        description = "kdeconnect tray";
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkg}/bin/kdeconnect-indicator";
          Restart = "on-failure";
        };
        wantedBy = ["graphical-session.target"];
      };
    };
  };
}
