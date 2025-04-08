{
  osConfig,
  lib,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.gui;
in {
  imports = [inputs.zen-browser.homeModules.beta];

  config = mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;
    };
  };
}
