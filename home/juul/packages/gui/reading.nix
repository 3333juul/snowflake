{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.lists) optionals concatLists;

  cfg = osConfig.garden.programs.reading;
  guiEnabled = osConfig.garden.presets.gui.enable;
in {
  home.packages = concatLists [
    (optionals (cfg.zotero.enable && guiEnabled) [
      pkgs.zotero
    ])

    (optionals (cfg.calibre.enable && guiEnabled) [
      pkgs.calibre
    ])

    (optionals guiEnabled [
      # pdf reader
      pkgs.evince
    ])

    [
      # TODO:

      #   pkgs.sioyek
      #   pkgs.zathura
      #
      #   # pdf operations
      #   pkgs.scantailor-advanced
      #   pkgs.briss # pdf cropping
    ]
  ];
}
