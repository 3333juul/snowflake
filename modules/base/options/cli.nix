{lib, ...}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
in {
  options.garden.programs.cli = {
    shell = mkOption {
      type = enum ["bash" "fish" "zsh"];
      default = "zsh";
      description = "shell to be used";
    };

    aichat.enable = mkEnableOption "enables aichat";
    enable = mkEnableOption "enables cli";
    git.enable = mkEnableOption "enables git";
    starship.enable = mkEnableOption "enables starship";
  };
}
