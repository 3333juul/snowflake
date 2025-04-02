{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self;
  inherit (lib.options) mkOption;
  inherit (lib.attrsets) mapAttrs filterAttrs;
  inherit (lib.lists) optionals concatLists;
  inherit (lib.types) listOf str;
  inherit (lib) nixosSystem;
  inherit (inputs.nix-darwin.lib) darwinSystem;
  inherit (builtins) elem;

  mkHost = host: {
    class ? "nixos",
    arch ? "x86_64",
    profiles ? [],
    extraModules ? [],
  }: let
    isIso =
      elem "iso" profiles;

    perClass =
      if class == "nixos"
      then "nixos/core"
      else class;

    system =
      if class == "darwin"
      then "${arch}-${class}"
      else "${arch}-linux";

    systemEval =
      if class == "darwin"
      then darwinSystem
      else nixosSystem;
  in
    systemEval
    {
      specialArgs = {
        inherit inputs lib;
      };

      modules = concatLists [
        (optionals (!isIso) [
          # modules per host
          "${self}/hosts/${host}"
          # common modules between all systems
          "${self}/modules/base"
          # modules per class: nixos, darwin
          "${self}/modules/${perClass}"
        ])

        # profile modules for different system types
        (map
          (profile: "${self}/modules/nixos/profiles/${profile}")
          profiles)
        # extra modules
        (map
          (module: "${self}/modules/${module}")
          extraModules)

        [
          # set hostname
          {networking.hostName = host;}
          # set system
          {nixpkgs.hostPlatform = system;}

          # add profiles as module options
          {
            options.garden.device.profiles = mkOption {
              type = listOf str;
              default = profiles;
            };
          }
        ]
      ];
    };

  # generate host configurations and assign them to darwin or nixos based on their class
  mkHosts = {
    nixos = hosts: let
      isNixOS = _: x: (x.class or "nixos") == "nixos";
    in
      mapAttrs mkHost (filterAttrs isNixOS hosts);

    darwin = hosts: let
      isDarwin = _: x: x.class == "darwin";
    in
      mapAttrs mkHost (filterAttrs isDarwin hosts);
  };
in {
  inherit mkHosts;
}
