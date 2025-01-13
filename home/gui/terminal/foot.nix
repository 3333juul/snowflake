{
  pkgs,
  osConfig,
  ...
}: let
  inherit (osConfig.garden.style) colors;
in {
  home.packages = with pkgs; [foot];
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
        #   alpha = "0.9";
        #   background = "282828";
        #   foreground = "ebdbb2";
        #   regular0 = "282828";
        #   regular1 = "cc241d";
        #   regular2 = "98971a";
        #   regular3 = "d79921";
        #   regular4 = "458588";
        #   regular5 = "b16286";
        #   regular6 = "689d6a";
        #   regular7 = "a89984";
        #   bright0 = "928374";
        #   bright1 = "fb4934";
        #   bright2 = "8ec07c";
        #   bright3 = "fabd2f";
        #   bright4 = "83a598";
        #   bright5 = "d3869b";
        #   bright6 = "8ec07c";
        #   bright7 = "ebdbb2";
        # };

        alpha = "0.9";
        foreground = "${colors.base06}";
        background = "${colors.base00}";
        regular0 = "${colors.base03}";
        regular1 = "${colors.base08}";
        regular2 = "${colors.base0B}";
        regular3 = "${colors.base0A}";
        regular4 = "${colors.base0D}";
        regular5 = "${colors.base0E}";
        regular6 = "${colors.base0C}";
        regular7 = "${colors.base06}";
        bright0 = "${colors.base04}";
        bright1 = "${colors.base08}";
        bright2 = "${colors.base0B}";
        bright3 = "${colors.base0A}";
        bright4 = "${colors.base0D}";
        bright5 = "${colors.base0F}";
        bright6 = "${colors.base0C}";
        bright7 = "${colors.base07}";
      };
    };
  };
}
