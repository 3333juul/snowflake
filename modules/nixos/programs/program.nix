{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.garden.programs;
in {
  programs = {
    # needed to interact with gtk
    dconf.enable = true;
    # home-manager needs it declared also here
    zsh.enable = lib.mkIf (cfg.cli.shell == "zsh") true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      # pinentryFlavor = "";
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [];
    };
  };
}
