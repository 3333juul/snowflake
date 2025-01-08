{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.garden.programs;
in {
  programs = {
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
