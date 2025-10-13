{
  inputs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.launcher;
in {
  imports = [inputs.vicinae.homeManagerModules.default];

  config = mkIf cfg.vicinae.enable {
    services.vicinae = {
      enable = true;
      autoStart = true;
    };
  };
}
