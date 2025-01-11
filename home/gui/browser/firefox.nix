{
  pkgs,
  osConfig,
  lib,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.gui;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      #floorp
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
