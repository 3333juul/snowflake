{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.lists) optionals;

  sys = config.garden.system;
  cfg = sys.virtualization;
in {
  config = cfg.enable {
    environment.systemPackages = optionals cfg.waydroid.enable [
      [pkgs.waydroid]
    ];
  };
}
