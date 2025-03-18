{
  perSystem = {pkgs, ...}: let
    inherit (pkgs) callPackage;
  in {
    packages = {
      gruvbox-material-gtk = callPackage ./gruvbox-material-gtk.nix {};
      hints = callPackage ./hints.nix {};
      hyprland-easymotion = callPackage ./hyprland-easymotion.nix {};
      hyprNStack = callPackage ./hyprnstack.nix {};
      rofi = callPackage ./rofi.nix {};
      stremio-letterboxd = callPackage ./stremio-letterboxd.nix {}; # TODO:
      vocabsieve = callPackage ./vocabsieve.nix {};
    };
  };
}
