{
  username,
  config,
  lib,
  ...
}: let
  cfg = config.garden.system;
in {
  services.displayManager.autoLogin = lib.mkIf cfg.autoLogin.enable {
    enable = true;
    user = "${username}";
  };

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';
}
