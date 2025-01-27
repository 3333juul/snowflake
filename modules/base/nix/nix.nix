{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # don't warn me if the current working tree is dirty
      warn-dirty = false;
    };
  };
}
