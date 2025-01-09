{...}: {
  imports = [
    ./cpu
    ./gpu
    ./bluetooth.nix
    ./hardware.nix
    ./pipewire.nix
  ];
}
