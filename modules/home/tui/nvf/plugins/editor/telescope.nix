{
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;

      setupOpts = {
        defaults = {
          layout_config.horizontal.prompt_position = "bottom";
          sorting_strategy = "descending";
          mappings.i = {
            "<C-j>" = "move_selection_next";
            "<C-k>" = "move_selection_previous";
          };
        };
      };

      mappings = {
        buffers = "<leader>.";
        #diagnostics = "<leader>sld";
        findFiles = "<leader> ";
        findProjects = "<leader>sp";
        #gitBranches = "<leader>svb";
        gitBufferCommits = "<leader>fc";
        #gitCommits = "<leader>svcw";
        #gitStash = "<leader>svx";
        #gitStatus = "<leader>svs";
        #helpTags = "<leader>ht";
        liveGrep = "<leader>sg";
        #lspDefinitions = "<leader>slD";
        #lspDocumentSymbols = "<leader>slsb";
        #lspImplementations = "<leader>sli";
        #lspReferences = "<leader>slr";
        #lspTypeDefinitions = "<leader>slt";
        #lspWorkspaceSymbols = "<leader>slsw";
        #open = "<leader>so";
        #resume = "<leader>sr";
        treesitter = "<leader>ss";
      };
    };

    keymaps = [
      {
        key = "<leader>nn";
        mode = "n";
        desc = "View notifications in telescope";
        action = "<cmd>Telescope notify<cr>";
      }
    ];
  };
}
