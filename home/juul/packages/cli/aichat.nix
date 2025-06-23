{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.presets;
in {
  config = mkIf cfg.cli.enable {
    home.packages = with pkgs; [aichat];
  };
}
