{...}: {
  imports = [
    ./environment
    ./hardware
    ./programs
    ./android.nix
    ./bootloader.nix
    ./network.nix
    ./security.nix
    ./services.nix
    ./syncthing.nix
    ./virtualization.nix
  ];
}
