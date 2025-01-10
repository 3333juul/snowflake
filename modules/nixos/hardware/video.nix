{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkMerge;

  cfg = config.garden.system.video;
in {
  config = mkIf cfg.enable (mkMerge [
    {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    }

    # benchmarking tools
    (mkIf cfg.benchmarking.enable {
      environment.systemPackages = [
        pkgs.mesa-demos
        pkgs.glmark2
      ];
    })
  ]);
}
