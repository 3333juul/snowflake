{inputs, ...}: let
  originLib = inputs.nixpkgs.lib;

  extLib = originLib.makeExtensible (
    self: let
      lib = self;
    in {
      builders = import ./mkHostConfig.nix {inherit lib;};

      inherit (self.builders) mkHostConfig;
    }
  );

  # We need to extend our Lib with the origin Lib to get the Full set of functions
  finalLib = extLib.extend (_: _: originLib);
in {
  flake.lib = finalLib;
  perSystem._module.args.lib = finalLib;
}
