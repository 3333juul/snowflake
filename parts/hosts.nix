{inputs, ...}: let
  inherit (inputs.self) lib;
  inherit (lib.builders) mkHosts;
  inherit (import "${inputs.self}/hosts") hosts;
in {
  # See parts/lib/builders.nix for the function implementation.
  flake = {
    nixosConfigurations = mkHosts.nixos hosts;
    darwinConfigurations = mkHosts.darwin hosts;
  };
}
