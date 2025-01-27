{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self;
  inherit (lib) nixosSystem;
  inherit (inputs.nix-darwin.lib) darwinSystem;

  mkHost = {
    host,
    class ? "nixos", # default class: nixos
    arch ? "x86_64", # default system: x86_64-linux
    profiles ? [],
  }: let
    system =
      if (class == "nixos" || class == "iso")
      then "${arch}-linux"
      else "${arch}-${class}";

    systemEval =
      if (class == "nixos" || class == "iso")
      then nixosSystem
      else darwinSystem;
  in
    systemEval
    {
      specialArgs = {
        inherit inputs;
      };

      modules =
        [
          # common modules between all systems
          "${self}/modules/base"
          # modules per class: nixos, darwin
          "${self}/modules/${class}"
          # modules per host
          "${self}/hosts/${host}"

          # set hostname
          {networking.hostName = host;}
          # set system
          {nixpkgs.hostPlatform = system;}
        ]
        ++ profiles;
    };
in {
  inherit mkHost;
}
