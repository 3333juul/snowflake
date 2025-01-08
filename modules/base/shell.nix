{
  lib,
  config,
  ...
}: let
  cfg = config.garden.programs;
in {
  programs = {
    # home-manager needs it declared also here
    zsh.enable = lib.mkIf (cfg.cli.shell == "zsh") true;
    fish.enable = lib.mkIf (cfg.cli.shell == "fish") true;
  };
}
