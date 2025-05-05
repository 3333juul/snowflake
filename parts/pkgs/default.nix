{
  perSystem = {pkgs, ...}: let
    inherit (pkgs) callPackage;
  in {
    packages = {
      gruvbox-material-gtk = callPackage ./gruvbox-material-gtk.nix {};
      hints = callPackage ./hints.nix {};
      hyprland-easymotion = callPackage ./hyprland-easymotion.nix {};
      hyprNStack = callPackage ./hyprnstack.nix {};
      memos = callPackage ./memos.nix {};
      vocabsieve = callPackage ./vocabsieve.nix {};
    };
  };
}
