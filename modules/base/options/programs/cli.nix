{lib, ...}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
in {
  options.garden.programs.cli = {
    enable = mkEnableOption "enables cli";

    shell = mkOption {
      type = enum ["bash" "fish" "zsh"];
      default = "zsh";
      description = "shell to be used";
    };

    aichat.enable = mkEnableOption "enables aichat";
    androidTools.enable = mkEnableOption "enables android tools";
    git.enable = mkEnableOption "enables git";
    starship.enable = mkEnableOption "enables starship";
  };
}
