# Overview

## Layout

- [flake.nix](flake.nix) Base of the configuration
- [home](home) My [Home-Manager](https://github.com/nix-community/home-manager)
  config
- [hosts](hosts) Per-host configurations that contain machine specific
  configurations
  - [desktop](hosts/desktop/) Desktop specific configuration
  - [laptop](hosts/laptop/) TODO
  - [vm](hosts/vm/) TODO
- [modules](modules) Modularized NixOS configurations
  - [profiles](modules/profiles/) Profiles for different system types
- [pkgs](flake/pkgs) Packages Build from source
- [wallpapers](wallpapers/) Default wallpapers

# Credits

- Nix Flakes
  - [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config)
  - [isabelroses/dotfiles](https://github.com/isabelroses/dotfiles)
  - [NotAShelf/nyx](https://github.com/NotAShelf/nyx)
