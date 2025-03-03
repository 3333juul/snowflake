{inputs, ...}: let
  inherit (inputs.self) lib;
  inherit (lib.builders) mkHosts;
  inherit (import ../hosts) hosts;
in {
  imports = [
    ./lib
    ./args.nix
  ];

  # See parts/lib/builders.nix for the function implementation.
  flake = {
    nixosConfigurations = mkHosts.nixos hosts;
    darwinConfigurations = mkHosts.darwin hosts;
  };
}
