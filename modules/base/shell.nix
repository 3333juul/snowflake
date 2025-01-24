{config, ...}: let
  cfg = config.garden.programs;
in {
  programs = {
    # home-manager needs it declared also here
    zsh.enable = cfg.cli.shell == "zsh";
    fish.enable = cfg.cli.shell == "fish";
  };
}
