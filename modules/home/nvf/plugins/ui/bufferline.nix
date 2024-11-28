{
  programs.nvf.settings.vim.tabline = {
    nvimBufferline = {
      enable = true;
      mappings = {
        cycleNext = "<S-l>";
        cyclePrevious = "<S-h>";
        closeCurrent = "<C-w>"; # "<leader>bb";
      };
      setupOpts = {
        options = {
          numbers = "none";
        };
      };
    };
  };
}
