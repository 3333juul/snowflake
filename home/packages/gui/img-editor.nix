{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.lists) optionals concatLists;

  cfg = osConfig.garden.programs.imageEditor;
in {
  home.packages = concatLists [
    (optionals cfg.gimp.enable [
      pkgs.gimp
    ])

    (optionals cfg.pinta.enable [
      pkgs.pinta
    ])
  ];
}
