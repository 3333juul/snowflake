{
  inputs,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.launcher;
in {
  imports = [inputs.vicinae.homeManagerModules.default];

  config = mkIf cfg.vicinae.enable {
    services.vicinae = {
      enable = true;
    };
  };
}
