{lib, ...}: {
  options.garden.cli = {
    bat.enable =
      lib.mkEnableOption "enables bat";

    fzf.enable =
      lib.mkEnableOption "enables fzf";

    btop.enable =
      lib.mkEnableOption "enables btop";

    starship.enable =
      lib.mkEnableOption "enables starship";

    shell = lib.mkOption {
      type = lib.types.enum ["bash" "fish" "zsh"];
      default = "zsh";
      description = "shell to be used";
    };
  };
}
