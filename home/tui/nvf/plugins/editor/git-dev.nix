{pkgs, ...}: let
  git-dev = pkgs.vimUtils.buildVimPlugin {
    pname = "git-dev-nvim";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "moyiz";
      repo = "git-dev-nvim";
      rev = "730e700bbe94083ce8ea2676934b5db43d32609f";
      sha256 = "sha256-CMqEb+pBuDbCRquoA8GhBoJk5J74VPLoQXloT6a4L/E=";
    };
  };
in {
  programs.nvf.settings.vim = {
    extraPlugins = {
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
