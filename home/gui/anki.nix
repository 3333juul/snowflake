{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  vocabsieve = pkgs.callPackage ../../pkgs/vocabsieve.nix {};
  cfg = osConfig.garden.programs.gui;
in {
  config = mkIf cfg.anki.enable {
    home.packages = with pkgs; [
      anki
      vocabsieve
    ];
  };
}
