{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.programs;

  inherit (lib.modules) mkIf;
in {
  programs.btop = mkIf cfg.tui.enable {
    enable = true;

    settings = {
      color_theme = "TTY";
      theme_background = false;
      update_ms = 500;
    };
  };

  home.packages = with pkgs; [nvtopPackages.intel];
}
