{
  pkgs,
  inputs,
  ...
}: let
  #monolisa = pkgs.callPackage ../../pkgs/monolisa/monolisa.nix {};
  #monolisa-nerd = pkgs.callPackage ../../pkgs/monolisa/monolisa-nerd.nix {inherit monolisa;};
  gruvbox-material-gtk = pkgs.callPackage ../../pkgs/gruvbox-material-gtk.nix {};
in {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraCode"
        "NerdFontsSymbolsOnly"
        "Iosevka"
      ];
    })
    twemoji-color-font
    noto-fonts-emoji
    # monolisa
    # monolisa-nerd
    terminus_font
    terminus_font_ttf
    terminus-nerdfont
    font-awesome
    noto-fonts

    #noto-fonts-color-emoji
    #material-icons
    #material-design-icons
  ];

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

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "kvantum";
    };
  };

  xdg.configFile = {
    "Kvantum/Gruvbox-Dark-Blue".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox-Dark-Blue";
    "Kvantum/Gruvbox-Dark-Brown".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox-Dark-Brown";
    "Kvantum/Gruvbox-Dark-Green".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox-Dark-Green";
    "Kvantum/Gruvbox_Light_Blue".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox_Light_Blue";
    "Kvantum/Gruvbox_Light_Brown".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox_Light_Brown";
    "Kvantum/Gruvbox_Light_Green".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox_Light_Green";

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Gruvbox-Dark-Brown
    '';
  };

  # xdg.configFile = {
  #   "Kvantum/gruvbox-kvantum/".source = "${inputs.gruvbox-kvantum}/gruvbox-kvantum/";
  #   "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=gruvbox-kvantum";
  # };

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
