{...}: {
  imports = [
    ./environment
    ./nix
    ./options
    ./programs
    ./android.nix
    ./bluetooth.nix
    ./bootloader.nix
    ./hardware.nix
    ./network.nix
    ./pipewire.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./syncthing.nix
    ./virtualization.nix
    ./wayland.nix
    ./xserver.nix
  ];
}
