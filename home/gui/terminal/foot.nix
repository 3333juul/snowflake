{ pkgs, ... }:
{
  home.packages = (with pkgs; [ foot ]);  
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Terminess Nerd Font:size=13.5";
      };
      scrollback = {
        lines = 5000;
        multiplier = 5;
      };
      colors = {
        alpha = "0.9";
        background = "282828";
        foreground = "ebdbb2";
        regular0 = "282828";
        regular1 = "cc241d";
        regular2 = "98971a";
        regular3 = "d79921";
        regular4 = "458588";
        regular5 = "b16286";
        regular6 = "689d6a";
        regular7 = "a89984";
        bright0 = "928374";
        bright1 = "fb4934";
        bright2 = "8ec07c";
        bright3 = "fabd2f";
        bright4 = "83a598";
        bright5 = "d3869b";
        bright6 = "8ec07c";
        bright7 = "ebdbb2";
      };
    };
  };
}
