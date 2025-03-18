{
  description = "luravoid's nixos configuration";

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./parts];};

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    agenix.url = "github:ryantm/agenix";
    hyprland.url = "github:hyprwm/hyprland";
    nvf.url = "github:notashelf/nvf";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
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

    # hyprland-easymotion = {
    #   url = "github:zakk4223/hyprland-easymotion/3388351d2af672f89b907404668c6076336270e9";
    #   inputs.hyprland.follows = "hyprland";
    # };
    #
    # hycov = {
    #   url = "github:bighu630/hycov";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };
}
