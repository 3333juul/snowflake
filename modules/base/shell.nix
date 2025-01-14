{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.programs;
in {
  programs = {
    # home-manager needs it declared also here
    zsh.enable = mkIf (cfg.cli.shell == "zsh") true;
    fish.enable = mkIf (cfg.cli.shell == "fish") true;
  };
}
