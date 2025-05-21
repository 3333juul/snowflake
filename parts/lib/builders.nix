{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self;
  inherit (lib.attrsets) mapAttrs filterAttrs;
  inherit (lib.modules) mkForce;

  inherit (lib.lists) optionals concatLists;
  inherit (lib) nixosSystem;
  inherit (inputs.nix-darwin.lib) darwinSystem;
  inherit (builtins) elem;

  mkHost = host: {
    class ? "nixos",
    arch ? "x86_64",
    profiles ? [],
    extraModules ? {},
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

    homeModules = concatLists [
      (optionals extraModules.homeManager.enable [
        "${self}/home"
        inputs.home-manager.nixosModules.home-manager
        {garden.environment.useHomeManager = mkForce true;}
      ])

      (optionals extraModules.hjem.enable [
        "${self}/hjem"
        inputs.hjem.nixosModules.default
        {garden.environment.useHjem = mkForce true;}
      ])
    ];
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

        homeModules

        [
          # set hostname
          {networking.hostName = host;}
          # set system
          {nixpkgs.hostPlatform = system;}
          # set profiles in the module system
          {garden.device.profiles = profiles;}
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
