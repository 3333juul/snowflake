{
  osConfig,
  lib,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.browser;
in {
  imports = [inputs.zen-browser.homeModules.beta];

  programs.zen-browser = mkIf cfg.zen.enable {
    enable = true;
  };
}
