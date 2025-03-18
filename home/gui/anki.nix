{
  lib,
  pkgs,
  osConfig,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (inputs.self.packages.${pkgs.system}) vocabsieve;

  cfg = osConfig.garden.programs;
in {
  config = mkIf cfg.anki.enable {
    home.packages = with pkgs; [
      anki
      vocabsieve
    ];
  };
}
