return {
  {
  "dundalek/lazy-lsp.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    require("lazy-lsp").setup {}
  end
  },
}

--[[ 
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {},
        bashls = {},
        rust_analyzer = {},
        tsserver = {},
      }
    }
  }
}
]]