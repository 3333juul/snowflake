{
  description = "luravoid's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    nvf.url = "github:notashelf/nvf";

    hyprland = {
      url = "github:hyprwm/hyprland";
    };

    pyprland.url = "github:hyprland-community/pyprland";

    # hyprland-easymotion = {
    #   url = "github:zakk4223/hyprland-easymotion/3388351d2af672f89b907404668c6076336270e9";
    #   inputs.hyprland.follows = "hyprland";
    # };
    #
    # hycov = {
    #   url = "github:bighu630/hycov";
    #   inputs.hyprland.follows = "hyprland";
    # };

    #hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";
    #nix-gaming.url = "github:fufexan/nix-gaming";
    #ags.url = "github:Aylur/ags";
    #yazi.url = "github:sxyazi/yazi";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:gerg-l/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gruvbox-kvantum-themes = {
      url = "github:sachnr/gruvbox-kvantum-themes";
      flake = false;
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    profilesPath = ./modules/profiles;

    desktop = profilesPath + /desktop;
    laptop = profilesPath + /laptop;
    server = profilesPath + /server;
    graphical = profilesPath + /graphical;
    headless = profilesPath + /headless;

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
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };

        modules =
          [
            # common modules between all systems
            ./modules/base
            # modules per class: nixos, darwin
            ./modules/${class}
            # modules per host
            ./hosts/${host}

            # set hostname
            {networking.hostName = host;}
            # set system
            {nixpkgs.hostPlatform = fullSystem;}
          ]
          ++ profiles;
      };
  in {
    nixosConfigurations = {
      desktop = mkHostConfig {
        host = "desktop";
        profiles = [
          desktop
          graphical
        ];
      };

      laptop = mkHostConfig {
        host = "laptop";
        profiles = [
          laptop
          graphical
        ];
      };

      server = mkHostConfig {
        host = "server";
        profiles = [
          server
          headless
        ];
      };
    };
  };
}
