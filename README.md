# Overview

## Layout

- [flake.nix](flake.nix) Base of the configuration
- [home](home) My [home-manager](https://github.com/nix-community/home-manager) config
- [hosts](hosts) Per-host configurations
  - [desktop](hosts/desktop/) Main machine
  - [laptop](hosts/laptop/) Low/mid spec thinkpad
  - [server](hosts/server/) TODO
  - [darwin](hosts/darwin/) TODO
- [modules](modules) Modular system configuration
  - [base](modules/base/) Base modules, common between all systems
  - [darwin](modules/nixos/) TODO
  - [nixos](modules/nixos/) NixOS specific modules
    - [core](modules/nixos/core/) Core modules
    - [profiles](modules/nixos/profiles/) Profiles for different system types
- [parts](parts) Flake parts
  - [lib](parts/lib/) My personal functions
  - [pkgs](parts/pkgs/) Packages built from source

## Gallery

<p align="center">
   <img src="./.github/assets/screenshots/desktop1.png" style="margin-bottom: 15px;"/> <br>
   Screenshots last updated: <b>10-01-2025</b>
</p>

# Credits

- Nix Flakes
  - [isabelroses/dotfiles](https://github.com/isabelroses/dotfiles)
  - [NotAShelf/nyx](https://github.com/NotAShelf/nyx)
  - [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config)
