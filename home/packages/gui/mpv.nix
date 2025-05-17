{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs;
in {
  programs.mpv = mkIf cfg.gui.enable {
    enable = true;
    package = pkgs.mpv;
    bindings = {
      h = "seek -5";
      l = "seek 5";
      j = "cycle sub";
      J = "cycle sub down";
      k = "cycle audio";
      K = "cycle audio down";
      H = "seek -60";
      L = "seek 60";
    };
    config = {
      keep-open = "yes";
      save-position-on-quit = "yes";
    };
  };
}
