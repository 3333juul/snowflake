{
  pkgs,
  inputs,
  ...
}: let
  inherit (builtins) concatStringsSep;
in {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum";
    };
  };

  xdg.configFile = {
    # Write kvantum configuration, and the theme files required by the Gruvbox theme.
    "Kvantum/kvantum.kvconfig".source = let
      themeName = "Gruvbox-Dark-Brown";
      themedApps = ["qt5ct" "org.kde.dolphin" "org.kde.kalendar" "org.qbittorrent.qBittorrent" "hyprland-share-picker" "dolphin-emu" "Nextcloud" "nextcloud" "cantata" "org.kde.kid3-qt"];
    in
      (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        General.theme = themeName;
        Applications."${themeName}" = concatStringsSep ", " themedApps;
      };

    "Kvantum/Gruvbox-Dark-Blue".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox-Dark-Blue";
    "Kvantum/Gruvbox-Dark-Brown".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox-Dark-Brown";
    "Kvantum/Gruvbox-Dark-Green".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox-Dark-Green";
    "Kvantum/Gruvbox_Light_Blue".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox_Light_Blue";
    "Kvantum/Gruvbox_Light_Brown".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox_Light_Brown";
    "Kvantum/Gruvbox_Light_Green".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox_Light_Green";
  };

  # xdg.configFile = {
  #   "Kvantum/gruvbox-kvantum/".source = "${inputs.gruvbox-kvantum}/gruvbox-kvantum/";
  #   "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=gruvbox-kvantum";
  # };

  home = {
    packages = with pkgs; [
      # Libraries and programs to ensure
      # that QT applications load without issues, e.g. missing libs.
      libsForQt5.qt5.qtwayland # qt5
      kdePackages.qtwayland # qt6
      qt6.qtwayland
      kdePackages.qqc2-desktop-style

      # qt5ct/qt6ct for configuring QT apps imperatively
      libsForQt5.qt5ct
      kdePackages.qt6ct

      # Some KDE applications such as Dolphin try to fall back to Breeze
      # theme icons. Lets make sure they're also found.
      #libsForQt5.breeze-qt5
      #kdePackages.breeze-icons
      #qt6.qtsvg # needed to load breeze icons

      # Libraries to ensure that "gtk" platform theme works
      # as intended after the following PR:
      # <https://github.com/nix-community/home-manager/pull/5156>
      #libsForQt5.qtstyleplugins
      #qt6Packages.qt6gtk2

      # Kvantum as a library and a program to theme qt applications
      # is added here, however, this will not have an effect
      # until QT_QPA_PLATFORMTHEME has been set appropriately
      # we still write the config files for Kvantum below
      # but again, it is a no-op until the env var is set
      libsForQt5.qtstyleplugin-kvantum
      qt6Packages.qtstyleplugin-kvantum
    ];
    sessionVariables = {
      # Scaling factor for QT applications. 1 means no scaling
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";

      # Use Wayland as the default backend, fallback to XCB if Wayland is not available
      QT_QPA_PLATFORM = "wayland;xcb";

      # Disable QT specific window decorations everywhere
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # Do remain backwards compatible with QT5 if possible.
      DISABLE_QT5_COMPAT = "0";

      # Tell Calibre to use the dark theme
      CALIBRE_USE_DARK_PALETTE = "1";

      # Already set by config options
      #QT_QPA_PLATFORMTHEME = "qt5ct";
      #QT_STYLE_OVERRIDE = "kvantum";
    };
  };
}
# inspo - https://github.com/NotAShelf/nyx/blob/main/homes%2Fnotashelf%2Fthemes%2Fqt.nix

