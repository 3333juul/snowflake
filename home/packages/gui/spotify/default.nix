{
  pkgs,
  lib,
  inputs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};

  cfg = osConfig.garden.programs;
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = mkIf cfg.spotify.enable {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      #shuffle # shuffle+ (special characters are sanitized out of extension names)

      {
        src = ./extensions;
        name = "keyboardShortcut.js";
      }
    ];
    #theme = spicePkgs.themes.dribbblish;
    #colorScheme = "gruvbox-material-dark";
  };
}
