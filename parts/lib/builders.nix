{
  inputs,
  lib,
  ...
}: let
  mkHostConfig = {
    host,
    class ? "nixos", # default class: nixos
    arch ? "x86_64", # default system: x86_64-linux
    profiles ? [],
  }: let
    system =
      if (class == "nixos" || class == "iso")
      then "${arch}-linux"
      else "${arch}-${class}";
  in
    lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };

      modules =
        [
          # common modules between all systems
          ../../modules/base
          # modules per class: nixos, darwin
          ../../modules/${class}
          # modules per host
          ../../hosts/${host}

          # set hostname
          {networking.hostName = host;}
          # set system
          {nixpkgs.hostPlatform = system;}
        ]
        ++ profiles;
    };
in {
  inherit mkHostConfig;
}
