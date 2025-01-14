{
  config,
  lib,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) bool;

  cfg = config.garden.programs.gui;
in {
  options.garden.style = {
    qt.enable = mkOption {
      type = bool;
      default = cfg.enable;
      description = "Whether to enable qt style config";
    };

    gtk.enable = mkOption {
      type = bool;
      default = cfg.enable;
      description = "Whether to enable gtk style config";
    };
  };
}
