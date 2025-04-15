{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  sys = config.garden.system;
  cfg = sys.virtualization;
in {
  config = mkIf (cfg.enable && cfg.waydroid.enable) {
    environment.systemPackages = [
      pkgs.waydroid
    ];
  };
}
