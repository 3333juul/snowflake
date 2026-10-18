{
  lib,
  pkgs,
  osConfig,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (inputs.self.packages.${pkgs.stdenv.hostPlatform.system}) vocabsieve;

  cfg = osConfig.garden.programs;
in {
  config = mkIf cfg.anki.enable {
    home.packages = [
      pkgs.anki
      vocabsieve
    ];
  };
}
