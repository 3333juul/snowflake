{
  programs.nvf.settings.vim.keymaps = [
    #= Better up/down =============================================================================
    {
      key = "j";
      mode = ["n" "x"];
      desc = "Down";
      action = "v:count == 0 ? 'gj' : 'j'";
      expr = true;
      silent = true;
    }
    {
      key = "k";
      mode = ["n" "x"];
      desc = "Up";
      action = "v:count == 0 ? 'gk' : 'k'";
      expr = true;
      silent = true;
    }
    {
      key = "<Down>";
      mode = ["n" "x"];
      desc = "Down";
      action = "v:count == 0 ? 'gj' : 'j'";
      expr = true;
      silent = true;
    }
    {
      key = "<Up>";
      mode = ["n" "x"];
      desc = "Up";
      action = "v:count == 0 ? 'gk' : 'k'";
      expr = true;
      silent = true;
    }

    #= Move to window using <ctrl> hjkl keys ======================================================
    {
      key = "<C-h>";
      mode = "n";
      desc = "Go to Left Window";
      action = "<C-w>h";
    }
    {
      key = "<C-j>";
      mode = "n";
      desc = "Go to Lower Window";
      action = "<C-w>j";
    }
    {
      key = "<C-k>";
      mode = "n";
      desc = "Go to Upper Window";
      action = "<C-w>k";
    }
    {
      key = "<C-l>";
      mode = "n";
      desc = "Go to Right Window";
      action = "<C-w>l";
    }

    #= Resize window using <ctrl> arrow keys ======================================================
    {
      key = "<C-Up>";
      mode = "n";
      desc = "Increase Window Height";
      action = "<cmd>resize +2<cr>";
    }
    {
      key = "<C-Down>";
      mode = "n";
      desc = "Decrease Window Height";
      action = "<cmd>resize -2<cr>";
    }
    {
      key = "<C-Left>";
      mode = "n";
      desc = "Decrease Window Width";
      action = "<cmd>vertical resize -2<cr>";
    }
    {
      key = "<C-Right>";
      mode = "n";
      desc = "Increase Window Width";
      action = "<cmd>vertical resize +2<cr>";
    }

    #= Move Lines =================================================================================
    {
      key = "<A-j>";
      mode = "n";
      desc = "Move Down";
      action = "<cmd>m .+1<cr>==";
    }
    {
      key = "<A-k>";
      mode = "n";
      desc = "Move Up";
      action = "<cmd>m .-2<cr>==";
    }
    {
      key = "<A-j>";
      mode = "i";
      desc = "Move Down";
      action = "<esc><cmd>m .+1<cr>==gi";
    }
    {
      key = "<A-k>";
      mode = "i";
      desc = "Move Up";
      action = "<esc><cmd>m .-2<cr>==gi";
    }
    {
      key = "<A-j>";
      mode = "v";
      desc = "Move Down";
      action = ":m '>+1<cr>gv=gv";
    }
    {
      key = "<A-k>";
      mode = "v";
      desc = "Move Up";
      action = ":m '<-2<cr>gv=gv";
    }

    #= Buffers ====================================================================================
    {
      key = "<S-h>";
      mode = "n";
      desc = "Prev Buffer";
      action = "<cmd>bprevious<cr>";
    }
    {
      key = "<S-l>";
      mode = "n";
      desc = "Next Buffer";
      action = "<cmd>bnext<cr>";
    }
    {
      key = "[b";
      mode = "n";
      desc = "Prev Buffer";
      action = "<cmd>bprevious<cr>";
    }
    {
      key = "]b";
      mode = "n";
      desc = "Next Buffer";
      action = "<cmd>bnext<cr>";
    }
    {
      key = "<leader>bb";
      mode = "n";
      desc = "Switch to Other Buffer";
      action = "<cmd>e #<cr>";
    }
    {
      key = "<leader>`";
      mode = "n";
      desc = "Switch to Other Buffer";
      action = "<cmd>e #<cr>";
    }
    {
      key = "<leader>bD";
      mode = "n";
      desc = "Delete Buffer and Window";
      action = "<cmd>:bd<cr>";
    }

    #= https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n ==============================
    {
      key = "n";
      mode = "n";
      desc = "Next Search Result";
      action = "'Nn'[v:searchforward].'zv'";
      expr = true;
    }
    {
      key = "n";
      mode = "x";
      desc = "Next Search Result";
      action = "'Nn'[v:searchforward]";
      expr = true;
    }
    {
      key = "n";
      mode = "o";
      desc = "Next Search Result";
      action = "'Nn'[v:searchforward]";
      expr = true;
    }
    {
      key = "N";
      mode = "n";
      desc = "Prev Search Result";
      action = "'nN'[v:searchforward].'zv'";
      expr = true;
    }
    {
      key = "N";
      mode = "x";
      desc = "Prev Search Result";
      action = "'nN'[v:searchforward]";
      expr = true;
    }
    {
      key = "N";
      mode = "o";
      desc = "Prev Search Result";
      action = "'nN'[v:searchforward]";
      expr = true;
    }

    #= Add undo break-points ======================================================================
    {
      key = ",";
      mode = "i";
      action = ",<c-g>u";
    }
    {
      key = ".";
      mode = "i";
      action = ".<c-g>u";
    }
    {
      key = ";";
      mode = "i";
      action = ";<c-g>u";
    }

    # Save file
    {
      key = "<C-s>";
      mode = "i";
      desc = "Save File";
      action = "<cmd>w<cr><esc>";
    }
    {
      key = "<C-s>";
      mode = "x";
      desc = "Save File";
      action = "<cmd>w<cr><esc>";
    }
    {
      key = "<C-s>";
      mode = "n";
      desc = "Save File";
      action = "<cmd>w<cr><esc>";
    }
    {
      key = "<C-s>";
      mode = "s";
      desc = "Save File";
      action = "<cmd>w<cr><esc>";
    }

    #= Better indenting ===========================================================================
    {
      key = "<";
      mode = "v";
      action = "<gv";
    }
    {
      key = ">";
      mode = "v";
      action = ">gv";
    }

    #= Commenting =================================================================================
    {
      key = "gco";
      mode = "n";
      desc = "Add Comment Below";
      action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
    }
    {
      key = "gcO";
      mode = "n";
      desc = "Add Comment Above";
      action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
    }

    #= New file ===================================================================================
    {
      key = "<leader>fn";
      mode = "n";
      desc = "New File";
      action = "<cmd>enew<cr>";
    }

    #= Quit All ===================================================================================
    {
      key = "<leader>qq";
      mode = "n";
      desc = "Quit All";
      action = "<cmd>qa<cr>";
    }
  ];
}
