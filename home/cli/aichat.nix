{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs;
in {
  config = mkIf cfg.aichat.enable {
    home.packages = with pkgs; [aichat];
  };
}
