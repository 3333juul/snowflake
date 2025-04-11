{
  programs.nvf.settings.vim = {
    diagnostics = {
      enable = true;
      config = {
        signs = false;
        underline = true;
        virtual_text = true;
        virtual_lines = false;
        update_in_insert = false;
      };
    };

    # toggle diagnostics
    keymaps = [
      {
        key = "<leader>ll";
        mode = "n";
        silent = true;
        lua = true;
        action = ''
          function()
            local new_config = not vim.diagnostic.config().virtual_text
            vim.diagnostic.config({virtual_text = new_config})
          end
        '';
        desc = "Toggle Virtual Lines";
      }
    ];
  };
}
