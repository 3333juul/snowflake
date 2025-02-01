{inputs, ...}: let
  inherit (inputs.self) lib;
  inherit (lib.attrsets) filterAttrs;
  inherit (lib.builders) mkHosts;

  # mkHost imports the following modules:
  # - host modules: Configurations specific to the host.
  # - base modules: Shared configurations for all systems.
  # - class modules: Configurations specific to the system class (e.g., nixos, darwin).
  # - profiles: Modules for different system types, explicitly set below.
  # See parts/lib/builders.nix for the function implementation.

  hosts = {
    desktop = {
      class = "nixos";
      arch = "x86_64";
      profiles = [
        "desktop"
        "graphical"
      ];
    };

    laptop = {
      class = "nixos";
      arch = "x86_64";
      profiles = [
        "laptop"
        "graphical"
      ];
    };

    server = {
      class = "nixos";
      arch = "x86_64";
      profiles = [
        "server"
        "headless"
      ];
    };

    darwin = {
      class = "darwin";
      arch = "x86_64";
    };
  };
in {
  flake = {
    darwinConfigurations = mkHosts (filterAttrs (_: cfg: cfg.class == "darwin") hosts);
    nixosConfigurations = mkHosts (filterAttrs (_: cfg: cfg.class == "nixos" || cfg.class == "iso") hosts);
  };
}
