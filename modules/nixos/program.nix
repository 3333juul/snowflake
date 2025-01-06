{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.garden.programs;
in {
  programs = {
    dconf.enable = true;
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
