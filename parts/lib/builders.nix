{
  inputs,
  lib,
  ...
}: let
  inherit (inputs) self;
  inherit (lib.attrsets) mapAttrs filterAttrs;
  inherit (lib) nixosSystem;
  inherit (inputs.nix-darwin.lib) darwinSystem;

  mkHost = host: {
    class ? "nixos", # default class: nixos
    arch ? "x86_64", # default system: x86_64-linux
    profiles ? [],
    extraModules ? [],
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
        inherit inputs lib;
      };

      modules =
        [
          # common modules between all systems
          "${self}/modules/base"
          # module options
          "${self}/modules/options"
          # modules per class: nixos, darwin
          "${self}/modules/${class}"
          # modules per host
          "${self}/hosts/${host}"

          # set hostname
          {networking.hostName = host;}
          # set system
          {nixpkgs.hostPlatform = system;}
        ]
        # profile modules for different system types
        ++ map (profile: "${self}/modules/profiles/${profile}") profiles
        # extra modules
        ++ map (module: "${self}/modules/${module}") extraModules;
    };

  # Generate host configurations and assign them to darwin or nixos based on their class
  #   mkHosts = hosts: let
  #     isDarwin = _: cfg: cfg.class == "darwin";
  #     isNixOS = _: cfg: (cfg.class or "nixos") == "nixos" || cfg.class == "iso";
  #   in {
  #     darwin = mapAttrs mkHost (filterAttrs isDarwin hosts);
  #     nixos = mapAttrs mkHost (filterAttrs isNixOS hosts);
  #   };

  # mkHosts = classes: hosts: let
  #   classList =
  #     if builtins.isList classes
  #     then classes
  #     else [classes];
  #
  #   filterByClass = _: cfg: builtins.elem (cfg.class or "nixos") classList;
  # in
  #   mapAttrs mkHost (filterAttrs filterByClass hosts);

  mkHosts = {
    nixos = hosts: let
      isNixOS = _: cfg: (cfg.class or "nixos") == "nixos" || cfg.class == "iso";
    in
      mapAttrs mkHost (filterAttrs isNixOS hosts);

    darwin = hosts: let
      isDarwin = _: cfg: cfg.class == "darwin";
    in
      mapAttrs mkHost (filterAttrs isDarwin hosts);
  };
in {
  inherit mkHosts;
}
