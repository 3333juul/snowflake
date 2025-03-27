{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  homeDir = config.home.homeDirectory;
  cfg = osConfig.garden.programs;
  nvf = osConfig.garden.programs.editor.neovim;
in {
  config = mkIf cfg.notes.enable {
    home.packages = [
      pkgs.obsidian
      pkgs.affine
    ];

    programs.nvf.settings.vim = mkIf nvf.enable {
      notes.obsidian = {
        # this also installs `vim-markdown` and `tabular` plugins:
        # https://github.com/NotAShelf/nvf/blob/main/modules/plugins/notes/obsidian/config.nix
        enable = true;
        setupOpts = {
          workspaces = [
            {
              name = "main";
              path = "${homeDir}/documents/knowledge/obsidian";
            }
          ];

          disable_frontmatter = true;
        };
      };

      # required for obsidian-nvim
      options.conceallevel = 2;

      luaConfigRC = {
        # https://github.com/preservim/vim-markdown/issues/622
        markdownUnfold = ''
          vim.cmd [[
            autocmd BufRead,BufNewFile *.markdown,*.md set foldlevelstart=6
          ]]
        '';
      };
    };
  };
}
