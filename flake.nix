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
  };

  outputs = {nixpkgs, ...} @ inputs: let
    commonModules = [
      ./modules/base
      ./modules/nixos
    ];

    profilesPath = ./modules/profiles;

    desktop = profilesPath + /desktop;
    laptop = profilesPath + /laptop;
    server = profilesPath + /server;
    graphical = profilesPath + /graphical;
    headless = profilesPath + /headless;

    mkHostConfig = {
      host,
      profiles ? [],
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs host;
        };
        modules =
          [./hosts/${host}]
          ++ commonModules
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
