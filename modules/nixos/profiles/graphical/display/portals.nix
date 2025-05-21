{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) optionalAttrs;
  inherit (config.garden.environment) isWM;
  inherit (config.garden.environment) isWayland;

  cfg = config.garden.environment.termFileChooser;
in {
  config = mkIf isWM {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      config.common =
        {
          default = ["gtk"];
        }
        // optionalAttrs cfg.enable {
          "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
        };

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-termfilechooser
      ];

      wlr = {
        enable = isWayland;
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
