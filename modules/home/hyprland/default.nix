{inputs, ...}: {
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprpolkitagent.nix
    ./pyprland.nix
    ./variables.nix
    inputs.hyprland.homeManagerModules.default
  ];
}
