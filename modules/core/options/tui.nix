{lib, ...}: {
  options.garden.programs.tui = {
    enable = lib.mkEnableOption "enables tui";

    nvim.enable =
      lib.mkEnableOption "enables nvim";

    yazi.enable =
      lib.mkEnableOption "enables yazi";

    btop.enable =
      lib.mkEnableOption "enables btop";

    fzf.enable =
      lib.mkEnableOption "enables fzf";

    cava.enable =
      lib.mkEnableOption "enables cava";

    lazygit.enable =
      lib.mkEnableOption "enables lazygit";
  };
}
