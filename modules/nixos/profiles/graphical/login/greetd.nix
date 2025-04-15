{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.garden.system) mainUser;
  inherit (lib.strings) concatStringsSep;

  cfg = config.garden.system.loginManager;

  sessionData = config.services.displayManager.sessionData.desktops;
  sessionPath = concatStringsSep ":" [
    "${sessionData}/share/xsessions"
    "${sessionData}/share/wayland-sessions"
  ];
in {
  services.greetd = mkIf (cfg.name == "greetd") {
    enable = true;
    restart = !cfg.autoLogin.enable;

    settings = {
      default_session = {
        user = "greeter";
        command = concatStringsSep " " [
          "${pkgs.greetd.tuigreet}/bin/tuigreet"
          "--time"
          "--time-format '%F %R'"
          "--remember"
          "--remember-user-session"
          "--asterisks"
          "--sessions '${sessionPath}'"
        ];
      };

      initial_session = mkIf cfg.autoLogin.enable {
        enable = true;
        user = mainUser;
        command = "Hyprland";
      };
    };
  };
}
