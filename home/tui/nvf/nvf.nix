{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.editor;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./plugins
    ./mappings.nix
  ];

  config = mkIf cfg.nvim.enable {
    xdg.desktopEntries = {
      nvim = {
        name = "Neovim";
        type = "Application";
        icon = "nvim";
        exec = "${pkgs.kitty}/bin/kitty nvim %F";
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        globals.mapleader = " ";
        useSystemClipboard = true;
        preventJunkFiles = true;
        # make indents normal
        options = {
          tabstop = 2;
          shiftwidth = 2;
          softtabstop = 2;
        };
      };
    };
  };
}
