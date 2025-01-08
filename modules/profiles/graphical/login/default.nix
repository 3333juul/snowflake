{
  username,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.garden.system;
in {
  services.greetd = lib.mkIf (cfg.loginManager == "greetd") {
    enable = true;
    restart = !cfg.autoLogin.enable;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland --time-format '%F %R'";
      };

      initial_session = lib.mkIf cfg.autoLogin.enable {
        enable = true;
        user = "${username}";
        command = "Hyprland";
      };
    };
  };

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';
}
