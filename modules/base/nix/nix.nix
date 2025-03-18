{
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (lib.hardware) ldTernary;

  sudoers = ldTernary pkgs "@wheel" "@admin";
in {
  nix = {
    # set the nix path, needed e.g. for nixd
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    settings = {
      # automatically optimise symlinks
      auto-optimise-store = true;

      # users or groups which are allowed to do anything with the Nix daemon
      allowed-users = [sudoers];
      # users or groups which are allowed to manage the nix store
      trusted-users = [sudoers];

      # don't warn me if the current working tree is dirty
      warn-dirty = false;

      # continue building derivations even if one fails
      keep-going = true;

      # show more log lines for failed builds
      log-lines = 30;

      # use xdg base directories for all the nix things
      use-xdg-base-directories = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
