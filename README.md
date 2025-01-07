# Overview

## Layout

- [flake.nix](flake.nix) base of the configuration
- [home](modules/home/) my
  [Home-Manager](https://github.com/nix-community/home-manager) config
- [hosts](hosts) per-host configurations that contain machine specific
  configurations
  - [desktop](hosts/desktop/) Desktop specific configuration
  - [laptop](hosts/laptop/) Laptop specific configuration
  - [vm](hosts/vm/) VM specific configuration
- [modules](modules) modularized NixOS configurations
- [pkgs](flake/pkgs) Packages Build from source
- [wallpapers](wallpapers/) wallpapers collection

# Credits

- Nix Flakes
  - [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config)
