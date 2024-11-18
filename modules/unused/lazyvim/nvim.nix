{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    #extraPackages = with pkgs; [
    #  nil
    #  lua-language-server
    #  bash-language-server
    #  typescript
    #  typescript-language-server
    #  stylua
    #];
  };

  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
