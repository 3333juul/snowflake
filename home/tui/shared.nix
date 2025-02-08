{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs;
in {
  config = mkIf cfg.tui.enable {
    home.packages = with pkgs; [
      tty-clock
      programmer-calculator
    ];
  };
}
