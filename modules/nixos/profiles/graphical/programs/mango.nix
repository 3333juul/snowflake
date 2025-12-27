{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.environment.desktop;
in {
  imports = [
    inputs.mango.nixosModules.mango
  ];

  programs.mango = mkIf (cfg.type == "mango") {
    enable = true;
  };
}
