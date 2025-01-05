{pkgs, ...}: {
  programs.nvf.settings.vim = {
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
      transparent = true;
    };
    # extraPlugins = with pkgs.vimPlugins; {
    #   gruvbox-material-nvim = {
    #     package = gruvbox-material-nvim;
    #     setup = "require('gruvbox-material').setup({
    #       italics = true,
    #       contrast = 'medium',
    #       comments = {
    #         italics = true,
    #       },
    #       background = {
    #         transparent = true,
    #       },
    #       float = {
    #         force_background = false,
    #         background_color = nil,
    #       },
    #       signs = {
    #         highlight = true,
    #       },
    #       customize = nil,
    #     })";
    #   };
    # };
  };
}
