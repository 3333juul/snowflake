{
  imports = [
    # coding
    ./coding/autopairs.nix
    ./coding/cmp.nix
    ./coding/comment.nix
    ./coding/git.nix

    # editor
    ./editor/cheatsheet.nix
    #./editor/git-dev.nix
    ./editor/neo-tree.nix
    ./editor/session-manager.nix
    ./editor/telescope.nix
    ./editor/terminal.nix
    ./editor/todo-comments.nix
    ./editor/which-key.nix
    ./editor/yazi.nix

    # lang
    ./lang/languages.nix
    ./lang/lsp.nix
    ./lang/treesitter.nix

    # ui
    ./ui/bufferline.nix
    ./ui/colorizer.nix
    ./ui/dashboard.nix
    #./ui/icons.nix
    #./ui/illuminate.nix
    ./ui/indent-blankline.nix
    ./ui/lualine.nix
    ./ui/noice.nix
    ./ui/nvim-notify.nix
    ./ui/rainbow-delimiters.nix
    ./ui/theme.nix

    # util
    #./util/image.nix
    ./util/obsidian.nix
  ];
}
