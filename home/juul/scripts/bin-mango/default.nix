{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.presets.gui;

  mkScript = name: script: pkgs.writeShellScriptBin name (builtins.readFile script);

  scripts = builtins.mapAttrs mkScript {
    togglemonocle = ./togglemonocle;
  };
in {
  config = mkIf cfg.enable {
    home.packages = builtins.attrValues scripts;
  };
}
