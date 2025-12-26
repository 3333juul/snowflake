{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs;
in {
  programs.spotify-player = mkIf cfg.spotify.tui.enable {
    enable = true;
    settings = {
    };
  };
}
