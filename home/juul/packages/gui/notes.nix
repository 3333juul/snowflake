{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;

  homeDir = config.home.homeDirectory;
  cfg = osConfig.garden.programs;
  nvf = osConfig.garden.programs.editor.neovim;
in {
  config = mkIf cfg.notes.enable {
    home.packages =
      [
        pkgs.obsidian
      ]
      ++ optionals cfg.notes.handwriting.enable [
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

      luaConfigRC = {
        # https://github.com/preservim/vim-markdown/issues/622
        markdownUnfold = ''
          vim.cmd [[
            autocmd BufRead,BufNewFile *.markdown,*.md set conceallevel=2 foldlevelstart=6
          ]]
        '';
      };
    };
  };
}
