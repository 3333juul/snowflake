{
  inputs,
  nixpkgs,
  self,
  username,
  host,
  ...
}: {
  imports = [
    ./android.nix
    ./bootloader.nix
    ./hardware.nix
    ./xserver.nix
    ./network.nix
    ./nh.nix
    ./pipewire.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./system.nix
    ./user.nix
    ./wayland.nix
    ./virtualization.nix
    ./bluetooth.nix
    ./syncthing.nix
  ];
}
