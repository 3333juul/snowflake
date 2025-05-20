{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.garden.environment.desktop.type;
in {
  config = lib.mkIf (cfg == "Hyprland") {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      config.common = {
        default = ["gtk"];

        "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
        # "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
      };

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-termfilechooser
      ];

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
