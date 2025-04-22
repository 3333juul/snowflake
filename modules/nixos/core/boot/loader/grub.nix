{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  cfg = config.garden.system.boot;
in {
  boot.loader.grub = mkIf (cfg.loader == "grub") {
    enable = mkDefault true;
    useOSProber = true;
    efiSupport = true;
    enableCryptodisk = mkDefault false;
    inherit (cfg.grub) device;
    theme = pkgs.minimal-grub-theme;
    backgroundColor = null;
    splashImage = null;
  };
}
