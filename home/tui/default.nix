{...}: {
  imports = [
    ./nvf/nvf.nix # nvim
    ./yazi # terminal file manager
    ./btop.nix # resource monitor
    ./cava.nix # audio visualizer
    ./fzf.nix # command-line fuzzy finder
  ];
}
