{
  username,
  config,
  lib,
  ...
}: let
  cfg = config.garden.desktop;
in {
  services.displayManager.autoLogin = lib.mkIf cfg.autostart.enable {
    enable = true;
    user = "${username}";
  };
}
