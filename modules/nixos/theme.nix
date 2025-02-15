{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.programs.gui;
in {
  config = mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme = "qt5ct";
    };
  };
}
