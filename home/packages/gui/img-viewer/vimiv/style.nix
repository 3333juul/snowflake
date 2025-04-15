{
  lib,
  osConfig,
  ...
}: let
  inherit (osConfig.garden.style) colors;

  gruvbox = {
    STYLE = {
      base00 = "#${colors.base00}";
      base01 = "#${colors.base01}";
      base02 = "#${colors.base02}";
      base03 = "#${colors.base03}";
      base04 = "#${colors.base04}";
      base05 = "#${colors.base05}";
      base06 = "#${colors.base06}";
      base07 = "#${colors.base07}";
      base08 = "#${colors.base08}";
      base09 = "#${colors.base09}";
      base0a = "#${colors.base0A}";
      base0b = "#${colors.base0B}";
      base0c = "#${colors.base0C}";
      base0d = "#${colors.base0D}";
      base0e = "#${colors.base0E}";
      base0f = "#${colors.base0F}";
    };
  };
in {
  xdg.configFile."vimiv/styles/gruvbox".text = lib.generators.toINI {} gruvbox;
}
