{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.garden.system) mainUser;

  cfg = config.garden.system.loginManager;
in {
  services.greetd = mkIf (cfg.name == "greetd") {
    enable = true;
    restart = !cfg.autoLogin.enable;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland --time-format '%F %R'";
      };

      initial_session = mkIf cfg.autoLogin.enable {
        enable = true;
        user = mainUser;
        command = "Hyprland";
      };
    };
  };
}
