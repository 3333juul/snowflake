{pkgs, ...}: let
  git-dev = pkgs.callPackage ../../../../../pkgs/git-dev-nvim.nix {};
in {
  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      git-dev = {
        package = git-dev;
        setup = "require('git-dev').setup{

          ephemeral = false,
          read_only = true,

       }";
      };
    };

    keymaps = [
      {
        key = "<leader>gr";
        mode = "n";
        desc = "Open github repo";
        action = "<cmd>call feedkeys(':GitDevOpen ')<cr>";
      }
      {
        key = "<leader>g.";
        mode = "n";
        desc = "Show last opened github repos";
        action = "<cmd>GitDevRecents<cr>";
      }
    ];
  };
}
