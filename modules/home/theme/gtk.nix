{pkgs, ...}: let
  gruvbox-material-gtk = pkgs.callPackage ../../../pkgs/gruvbox-material-gtk.nix {};
in {
  gtk = {
    enable = true;
    font = {
      name = "Noto Sans";
      size = 12;
    };
    theme = {
      name = "Gruvbox-Material-Dark";
      package = gruvbox-material-gtk;
    };
    iconTheme = {
      name = "Gruvbox-Material-Dark";
      package = gruvbox-material-gtk;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };
}
