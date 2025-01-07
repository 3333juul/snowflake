{
  programs.nvf.settings.vim = {
    terminal.toggleterm = {
      enable = true;

      mappings.open = "<c-t>";
      setupOpts = {
        winbar.enabled = false;
        direction = "float";
      };

      lazygit = {
        enable = true;
        mappings.open = "<leader>gl";
      };
    };
  };
}
