{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.environment;
in {
  systemd.user.services = mkIf cfg.isWM {
    polkit-authentication-agent = {
      description = "PolicyKit Authentication Agent";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
        #ExecStart = "${inputs.hyprpolkitagent.packages.${pkgs.system}.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
    };
  };
}
