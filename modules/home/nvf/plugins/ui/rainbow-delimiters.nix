{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      rainbow-delimiters-nvim = {
        package = rainbow-delimiters-nvim;
        setup = "require('rainbow-delimiters.setup').setup { 
          highlight = {
              'RainbowDelimiterViolet',
              'RainbowDelimiterBlue',
              'RainbowDelimiterGreen',
              'RainbowDelimiterYellow',
              'RainbowDelimiterOrange',
              'RainbowDelimiterCyan',
              'RainbowDelimiterRed',
          },
        }";
      };
    };
  };
}
