# following https://github.com/NixOS/nixpkgs/blob/77ee426a4da240c1df7e11f48ac6243e0890f03e/lib/default.nix
# as a rough template we can create our own extensible lib and expose it to the flake
# we can then use that elsewhere like our hosts
{inputs, ...}: let
  originLib = inputs.nixpkgs.lib;

  extLib = originLib.makeExtensible (
    self: let
      lib = self;
    in {
      builders = import ./builders.nix {inherit inputs lib;};
      hardware = import ./hardware.nix;

      inherit (self.builders) mkHosts;
      inherit (self.hardware) isx86Linux ldTernary primaryMonitor monitor;
    }
  );

  # We need to extend our Lib with the origin Lib to get the Full set of functions
  finalLib = extLib.extend (_: _: originLib);
in {
  flake.lib = finalLib;

  perSystem._module.args.lib = finalLib;
}
