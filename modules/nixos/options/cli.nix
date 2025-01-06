{lib, ...}: {
  options.garden.programs.cli = {
    enable = lib.mkEnableOption "enables cli";

    shell = lib.mkOption {
      type = lib.types.enum ["bash" "fish" "zsh"];
      default = "zsh";
      description = "shell to be used";
    };

    bat.enable =
      lib.mkEnableOption "enables bat";

    starship.enable =
      lib.mkEnableOption "enables starship";

    git.enable =
      lib.mkEnableOption "enables git";
  };
}
