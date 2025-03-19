{config, ...}: let
  homeDir = config.home.homeDirectory;
in {
  programs.nvf.settings.vim = {
    notes.obsidian = {
      # it also installs `vim-markdown` and `tabular` plugins
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
}
