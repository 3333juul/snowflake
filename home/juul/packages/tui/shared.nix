{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;

  cfg = osConfig.garden.programs;
  wrl = osConfig.garden.system.networking.wirelessBackend;
in {
  config = mkIf cfg.tui.enable {
    home.packages = with pkgs;
      [
        tty-clock # clock
        bluetui # bluetooth
        programmer-calculator # calculator
      ]
      # wifi
      ++ optionals (wrl == "iwd")
      [impala];
  };
}
