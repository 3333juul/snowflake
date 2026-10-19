{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;

  cfg = osConfig.garden.presets.tui;
  wrl = osConfig.garden.system.networking.wirelessBackend;
in {
  config = mkIf cfg.enable {
    home.packages =
      with pkgs; [
        tty-clock # clock
        programmer-calculator # calculator
      ]
      # bluetooth
      ++ optionals osConfig.garden.device.hasBluetooth [bluetui]
      # wifi
      ++ optionals (wrl == "iwd" && osConfig.garden.device.type != "wsl") [impala];
  };
}
