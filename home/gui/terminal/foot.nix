{
  osConfig,
  lib,
  ...
}: let
  inherit (osConfig.garden.style) colors;
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.terminal.foot;
in {
  programs.foot = mkIf cfg.enable {
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
