{config, ...}: let
  inherit (config.garden.programs.cli) shell;
in {
  programs = {
    # home-manager needs it declared also here
    zsh.enable = shell == "zsh";
    fish.enable = shell == "fish";
  };
}
