{inputs, ...}: let
  # Import lib from `self` instead of `nixpkgs` to get the access to mkHost
  inherit (inputs.self) lib;
  # Import mkHost from my custom flake-parts lib
  inherit (lib.builders) mkHost;

  # Define path to profile modules
  profilesPath = ../modules/profiles;

  # Define individual profiles for different system types
  desktop = profilesPath + /desktop; # Desktop-specific configurations
  laptop = profilesPath + /laptop; # Laptop-specific configurations
  server = profilesPath + /server; # Server-specific configurations
  graphical = profilesPath + /graphical; # Graphical environment configurations
  headless = profilesPath + /headless; # Headless (no GUI) configurations
in {
  flake = {
    # mkHost imports the following modules:
    # - base modules: Shared configurations for all systems.
    # - class modules: Configurations specific to the system class (e.g., nixos, darwin).
    # - host modules: Configurations specific to the host.
    # - profiles: Modules for different system types, explicitly set below.
    # See parts/lib/builders.nix for the function implementation.

    nixosConfigurations = {
      desktop = mkHost {
        host = "desktop"; # Hostname for the system
        class = "nixos"; # System class
        arch = "x86_64"; # System architecture
        profiles = [
          desktop
          graphical
        ];
      };

      laptop = mkHost {
        host = "laptop";
        class = "nixos";
        arch = "x86_64";
        profiles = [
          laptop
          graphical
        ];
      };

      server = mkHost {
        host = "server";
        class = "nixos";
        arch = "x86_64";
        profiles = [
          server
          headless
        ];
      };
    };

    # darwinConfigurations = {
    #   darwin = mkHost {
    #     host = "darwin";
    #     class = "darwin";
    #     arch = "x86_64";
    #   };
    # };
  };
}
