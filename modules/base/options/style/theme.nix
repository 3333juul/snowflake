{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.validators) hasProfile;
  inherit (lib.options) mkOption;
  inherit (lib.types) bool;
in {
  options.garden.style = {
    qt.enable = mkOption {
      type = bool;
      default = hasProfile config ["graphical"] && pkgs.stdenv.hostPlatform.isLinux;
      description = "Whether to enable qt style config";
    };

    gtk.enable = mkOption {
      type = bool;
      default = hasProfile config ["graphical"] && pkgs.stdenv.hostPlatform.isLinux;
      description = "Whether to enable gtk style config";
    };
  };
}
