{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.garden.programs.tui = {
    enable = mkEnableOption "enables tui";

    btop.enable = mkEnableOption "enables btop";
    cava.enable = mkEnableOption "enables cava";
    fzf.enable = mkEnableOption "enables fzf";
    lazygit.enable = mkEnableOption "enables lazygit";
    nvim.enable = mkEnableOption "enables nvim";
    yazi.enable = mkEnableOption "enables yazi";
  };
}
