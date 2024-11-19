{
  pkgs,
  inputs,
  ...
}: {
  systemd.user.services.hyprpolkitagent = {
    Unit = {
      ConditionEnvironment = "WAYLAND_DISPLAY";
      Description = "Hyprland Polkit Authentication Agent";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${inputs.hyprpolkitagent.packages.${pkgs.system}.hyprpolkitagent}/libexec/hyprpolkitagent";
      Slice = "session.slice";
      TimeoutStopSec = "5sec";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
