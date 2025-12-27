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
      autoStart = true;

      settings = {
        theme = {
          light = {
            name = "gruvbox-light";
            icon_theme = "default";
          };
          dark = {
            name = "gruvbox-dark";
            icon_theme = "default";
          };
        };
      };

      extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
        bluetooth
        nix
      ];
    };
  };
}
