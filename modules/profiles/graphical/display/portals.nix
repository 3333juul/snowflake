{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.garden.environment.desktop;
in {
  config = lib.mkIf (cfg == "Hyprland") {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      # config.common = {
      #   default = ["gtk"];
      #
      #   "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      # };

      extraPortals = [pkgs.xdg-desktop-portal-gtk];

      wlr = {
        enable = true;
        settings = {
          # screencast = {
          #   max_fps = 60;
          #   chooser_type = "simple";
          #   chooser_cmd = "${getExe pkgs.slurp} -f %o -or";
          # };
        };
      };
    };
  };
}
