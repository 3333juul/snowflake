{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.programs.fileManager;
in {
  config = mkIf cfg.thunar.enable {
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
      };

      xfconf.enable = true;
    };

    services.tumbler.enable = true;
  };
}
