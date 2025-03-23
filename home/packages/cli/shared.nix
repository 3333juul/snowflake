{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs;
in {
  config = mkIf cfg.cli.enable {
    home.packages = with pkgs; [
      cocogitto # git helpers
      eza # ls replacement
      entr # perform action when file change
      fd # find replacement
      file # Show file information
      killall
      ncdu # disk space
      ripgrep # grep replacement
      tldr
      unzip
      jq

      python3

      # nix tools
      nix-prefetch-github
      nix-output-monitor
      nvd
    ];
  };
}
