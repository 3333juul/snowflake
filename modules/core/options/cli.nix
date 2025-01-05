{lib, ...}: {
  options.garden.cli = {
    bat.enable =
      lib.mkEnableOption "enables bat";

    zsh.enable =
      lib.mkEnableOption "enables zsh";

    fzf.enable =
      lib.mkEnableOption "enables fzf";

    btop.enable =
      lib.mkEnableOption "enables btop";

    starship.enable =
      lib.mkEnableOption "enables starship";
  };
}
