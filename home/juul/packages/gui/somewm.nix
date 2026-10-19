{
  lib,
  pkgs,
  inputs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.presets.gui;

  inherit (inputs.self.packages.${pkgs.stdenv.hostPlatform.system}) somewm;
in {
  config = mkIf cfg.enable {
    home.packages = [
      somewm
    ];
  };
}
