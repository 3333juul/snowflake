{inputs, ...}: let
  inherit (inputs.self) lib;
  inherit (lib.builders) mkHosts;
  inherit (import ../hosts) hosts;
in {
  systems = import inputs.systems;

  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };
      overlays = [];
    };
  };

  # See parts/lib/builders.nix for the function implementation.
  flake = {
    nixosConfigurations = (mkHosts hosts).nixos;
    darwinConfigurations = (mkHosts hosts).darwin;
  };
}
