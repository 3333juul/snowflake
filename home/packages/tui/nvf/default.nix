{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  # inherit (inputs.nvf.lib.nvim.dag) entryAfter entryBefore;

  cfg = osConfig.garden.programs.editor;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./plugins
    ./mappings.nix
  ];

  config = mkIf cfg.neovim.enable {
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
        useSystemClipboard = true;
        preventJunkFiles = true;
        options = {
          # make indents normal
          tabstop = 2;
          shiftwidth = 2;
          softtabstop = 2;
        };

        # luaConfigRC = {
        #   markdownDisableFolding = entryBefore ["pluginConfigs"] ''
        #     vim.g.vim_markdown_folding_disabled = 1
        #   '';
        # };
      };
    };
  };
}
