{
  programs.nvf.settings.vim = {
    lsp = {
      formatOnSave = true;
      lightbulb.enable = false;
      lspsaga.enable = false;
      trouble.enable = false;
      lspSignature.enable = false;
      lspconfig.enable = true;
    };

    # https://neovim.io/doc/user/diagnostic.html
    luaConfigPre = ''
      vim.diagnostic.config({virtual_text = true})
      vim.lsp.inlay_hint.enable(true)
    '';

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
