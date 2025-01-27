{
  nix = {
    settings = {
      # automatically optimise symlinks
      auto-optimise-store = true;

      # don't warn me if the current working tree is dirty
      warn-dirty = false;

      # continue building derivations even if one fails
      keep-going = true;

      # show more log lines for failed builds
      log-lines = 30;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
