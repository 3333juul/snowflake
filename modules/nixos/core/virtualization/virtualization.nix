{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  sys = config.garden.system;
  cfg = sys.virtualization;
in {
  config = mkIf cfg.enable {
    virtualisation = {
      kvmgt.enable = true;
      spiceUSBRedirection.enable = true;

      waydroid.enable = cfg.waydroid.enable;
    };
  };
}
