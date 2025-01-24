{
  inputs,
  lib,
}: let
  classToOS = class:
    if class == "nixos"
    then "linux"
    else "darwin";

  mkHostConfig = {
    host,
    class ? "nixos", # default class: nixos
    system ? "x86_64", # default system: x86_64-linux
    profiles ? [],
  }: let
    fullSystem = "${system}-${classToOS class}";
  in
    lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };

      modules =
        [
          # common modules between all systems
          ../modules/base
          # modules per class: nixos, darwin
          ../modules/${class}
          # modules per host
          ../hosts/${host}

          # set hostname
          {networking.hostName = host;}
          # set system
          {nixpkgs.hostPlatform = fullSystem;}
        ]
        ++ profiles;
    };
in {
  inherit mkHostConfig;
}
