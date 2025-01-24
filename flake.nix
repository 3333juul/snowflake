{
  description = "luravoid's nixos configuration";

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./parts];};

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";

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

    flake-parts.url = "github:hercules-ci/flake-parts";
  };
}
