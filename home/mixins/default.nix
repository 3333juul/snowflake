{
  # mixins: files used by both nixos system config and home-manager
  imports = [
    ./agenix.nix
    ./clean-zsh.nix
  ];
}
