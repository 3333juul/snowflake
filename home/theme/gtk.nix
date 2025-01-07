{
  pkgs,
  config,
  ...
}: let
  gruvbox-material-gtk = pkgs.callPackage ../../pkgs/gruvbox-material-gtk.nix {};
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

    # Move gtk-2.0 from home directory to .config
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Gruvbox-Material-Dark";
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };
}
