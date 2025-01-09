{pkgs, ...}: {
  programs.nvf.settings.vim = {
    # telescope = {
    #   enable = true;
    #
    #   setupOpts = {
    #     defaults = {
    #       layout_config.horizontal.prompt_position = "bottom";
    #       sorting_strategy = "descending";
    #       mappings.i = {
    #         "<C-j>" = "move_selection_next";
    #         "<C-k>" = "move_selection_previous";
    #       };
    #     };
    #   };
    #
    #   mappings = {
    #     buffers = "<leader>.";
    #     #diagnostics = "<leader>sld";
    #     findFiles = "<leader> ";
    #     findProjects = "<leader>sp";
    #     #gitBranches = "<leader>svb";
    #     gitBufferCommits = "<leader>fc";
    #     #gitCommits = "<leader>svcw";
    #     #gitStash = "<leader>svx";
    #     #gitStatus = "<leader>svs";
    #     #helpTags = "<leader>ht";
    #     liveGrep = "<leader>sg";
    #     #lspDefinitions = "<leader>slD";
    #     #lspDocumentSymbols = "<leader>slsb";
    #     #lspImplementations = "<leader>sli";
    #     #lspReferences = "<leader>slr";
    #     #lspTypeDefinitions = "<leader>slt";
    #     #lspWorkspaceSymbols = "<leader>slsw";
    #     #open = "<leader>so";
    #     #resume = "<leader>sr";
    #     treesitter = "<leader>ss";
    #   };
    # };

    extraPlugins = with pkgs.vimPlugins; {
      telescope-fzf = {
        package = telescope-fzf-native-nvim;
        setup = "
             require('telescope').setup {
                defaults = {
                   mappings = {
                     i = {
                       ['<C-j>'] = 'move_selection_next',
                       ['<C-k>'] = 'move_selection_previous',
                     }
                   }
                },

                extensions = {
                  fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
                  }
                }
             }
          -- To get fzf loaded and working with telescope, you need to call this:
             require('telescope').load_extension('fzf')
        ";
      };
    };

    keymaps = [
      {
        key = "<leader> ";
        mode = "n";
        desc = "telescope";
        action = "<cmd>Telescope find_files<cr>";
      }

      {
        key = "<leader>.";
        mode = "n";
        desc = "telescope";
        action = "<cmd>Telescope buffers<cr>";
      }

      {
        key = "<leader>sg";
        mode = "n";
        desc = "telescope";
        action = "<cmd>Telescope live_grep<cr>";
      }

      {
        key = "<leader>fc";
        mode = "n";
        desc = "telescope";
        action = "<cmd>Telescope git_bcommits<cr>";
      }

      {
        key = "<leader>nn";
        mode = "n";
        desc = "View notifications in telescope";
        action = "<cmd>Telescope notify<cr>";
      }
    ];
  };
}
