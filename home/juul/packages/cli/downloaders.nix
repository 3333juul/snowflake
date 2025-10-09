{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.presets.cli;
in {
  config = mkIf cfg.enable {
    programs.gallery-dl = {
      enable = true;
    };

    home.packages = [
      #pkgs.instaloader
      pkgs.yt-dlp-light
    ];
  };
}
