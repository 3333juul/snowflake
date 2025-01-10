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

## Gallery

<p align="center">
   <img src="./.github/assets/screenshots/desktop1.png" style="margin-bottom: 15px;"/> <br>
   Screenshots last updated: <b>10-01-2025</b>
</p>

# Credits

- Nix Flakes
  - [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config)
  - [isabelroses/dotfiles](https://github.com/isabelroses/dotfiles)
  - [NotAShelf/nyx](https://github.com/NotAShelf/nyx)
