{
  lib,
  fetchFromGitHub,
  pkgs,
  ...
}:
pkgs.vimUtils.buildVimPlugin {
  pname = "git-dev-nvim";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "moyiz";
    repo = "git-dev-nvim";
    rev = "730e700bbe94083ce8ea2676934b5db43d32609f";
    sha256 = "sha256-CMqEb+pBuDbCRquoA8GhBoJk5J74VPLoQXloT6a4L/E=";
  };

  meta = with lib; {
    description = "Open remote git repositories in the comfort of Neovim.";
    homepage = "https://github.com/moyiz/git-dev.nvim";
    maintainers = with maintainers; [luravoid];
  };
}
