{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.tui;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./plugins
    ./mappings.nix
  ];

  config = lib.mkIf cfg.nvim.enable {
    xdg.desktopEntries = {
      nvim = {
        name = "Neovim";
        type = "Application";
        mimeType = ["text/plain"];
        icon = "nvim";
        exec = "${pkgs.kitty}/bin/kitty nvim";
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
      };
    };
  };
}
