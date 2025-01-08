{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.tui;
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
