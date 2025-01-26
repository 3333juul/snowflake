# Overview

## Layout

- [flake.nix](flake.nix) base of the configuration
- [home](home) my [home-manager](https://github.com/nix-community/home-manager)
  config
- [hosts](hosts) per-host configurations that contain machine specific
  configurations
  - [desktop](hosts/desktop/) main machine
  - [laptop](hosts/laptop/) low/mid spec thinkpad
  - [server](hosts/server/) TODO
  - [vm](hosts/vm/) TODO
- [modules](modules) modular system configuration
  - [base](modules/base/) base modules, common between all systems
  - [nixos](modules/nixos/) nixOS specific modules
  - [darwin](modules/nixos/) TODO
  - [profiles](modules/profiles/) profiles for different system types
- [parts](parts) flake-parts
  - [lib](parts/lib/) personal functions
- [pkgs](pkgs) packages built from source

## Gallery

<p align="center">
   <img src="./.github/assets/screenshots/desktop1.png" style="margin-bottom: 15px;"/> <br>
   screenshots last updated: <b>10-01-2025</b>
</p>

# Credits

- Nix Flakes
  - [isabelroses/dotfiles](https://github.com/isabelroses/dotfiles)
  - [NotAShelf/nyx](https://github.com/NotAShelf/nyx)
  - [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config)
