# Overview

NixOS config, designed with modularity, efficiency, and clarity as its top priorities

## Notable features

- **Modularity** - Every part of this config is modular and can be enabled or disabled based on the host configuration. This is achieved through [the profiles concept](modules/nixos/profiles/) and [the module system](modules/base/options/).
- **Various device settings** - Offers configurations for multiple PC components. The existing structure allows easy extension in case your device isn't fully compatible.
- **An extensive home-manager configuration** - Includes configs for Hyprland, Neovim, and other essential tools for a comfortable workflow.
- **Flakes made modular** - Thanks to [flake-parts](https://flake.parts/), which comes with many useful utilities.
- **Syncing and backup tools (Syncthing, Restic, Rclone)** - Ensures your files are always where they need to be.
- **Secrets management** - Handled by [agenix](https://github.com/ryantm/agenix), ensuring your sensitive data remains secure.
- **Virtualization tools** - Qemu, Waydroid, Distrobox.
- **Specializations** - Enables multiple configurations to be available in the boot selection on the same machine. This is useful if you want to switch between different desktop environments without rebuilding the system.

## Layout

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
- [flake.nix](flake.nix) Base of the configuration

## Gallery

<p align="center">
  <img src="./.github/assets/screenshots/desktop1.png" style="margin-bottom: 15px;"/> <br>
   <b>Last updated: January 10, 2025.</b>
</p>

## Credits

My biggest inspiration for this config is isabelroses's amazing dotfiles, from which I took the config organization and various components. Isabel also helped me understand some of the more advanced aspects of her config.
So, huge credit goes to her! If you want to learn best practices for managing Nix configurations, I highly recommend checking out her config.

[isabelroses/dotfiles](https://github.com/isabelroses/dotfiles)

### Other high quality configs

[NotAShelf/nyx](https://github.com/NotAShelf/nyx)
