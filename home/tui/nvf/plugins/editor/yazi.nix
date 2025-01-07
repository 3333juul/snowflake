{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      yazi-nvim = {
        package = yazi-nvim;
        setup = "require('yazi').setup{}";
      };
    };
    maps.normal = {
      "<leader>sy" = {
        desc = "Yazi";
        action = "<cmd>Yazi<cr>";
      };
    };
  };
}
