{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.lists) optionals concatLists;

  cfg = osConfig.garden.programs.reading;
in {
  home.packages = concatLists [
    (optionals cfg.zotero.enable [
      pkgs.zotero
    ])

    (optionals cfg.calibre.enable [
      pkgs.calibre
    ])
  ];
}
