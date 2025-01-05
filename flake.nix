{
  description = "luravoid's nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";

    nix-gaming.url = "github:fufexan/nix-gaming";

    #ags.url = "github:Aylur/ags";

    nvf.url = "github:notashelf/nvf/v0.7";

    yazi.url = "github:sxyazi/yazi";

    hyprland = {
      url = "github:hyprwm/hyprland";
    };

    hyprland-easymotion = {
      url = "github:zakk4223/hyprland-easymotion/3388351d2af672f89b907404668c6076336270e9";
      inputs.hyprland.follows = "hyprland";
    };

    hycov = {
      url = "github:bighu630/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    pyprland.url = "github:hyprland-community/pyprland";

    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";

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

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    username = "scay";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./hosts/desktop];
        specialArgs = {
          host = "desktop";
          inherit self inputs username;
        };
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./hosts/laptop];
        specialArgs = {
          host = "laptop";
          inherit self inputs username;
        };
      };
      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./hosts/vm];
        specialArgs = {
          host = "vm";
          inherit self inputs username;
        };
      };
    };
  };
}
