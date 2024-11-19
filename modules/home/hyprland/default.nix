{inputs, ...}: {
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./pyprland.nix
    ./variables.nix
    inputs.hyprland.homeManagerModules.default
  ];
}
