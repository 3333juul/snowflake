{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self;
  inherit (inputs.nix-darwin.lib) darwinSystem;
  inherit (lib) nixosSystem;
  inherit (lib.lists) optionals concatLists;
  inherit (lib.modules) mkForce;
  inherit (lib.attrsets) mapAttrs filterAttrs recursiveUpdate;
  inherit (builtins) elem;

  mkHost = host: {
    class ? "nixos",
    arch ? "x86_64",
    profiles ? [],
    extraModules ? {},
  }: let
    em =
      recursiveUpdate {
        homeManager.enable = false;
        hjem.enable = false;
      }
      extraModules;

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

        # extra modules: home-manager
        (optionals em.homeManager.enable [
          "${self}/home"
          inputs.home-manager.nixosModules.home-manager
          {garden.environment.useHomeManager = mkForce true;}
        ])

        # extra modules: hjem
        (optionals em.hjem.enable [
          "${self}/hjem"
          inputs.hjem.nixosModules.default
          {garden.environment.useHjem = mkForce true;}
        ])

        [
          # set hostname
          {networking.hostName = host;}
          # set system
          {nixpkgs.hostPlatform = system;}
          # set profiles in the module system
          {garden.device.profiles = mkForce profiles;}
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
