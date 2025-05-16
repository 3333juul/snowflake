{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.environment.desktop;
in {
  imports = [
    ./modules.nix
  ];

  programs.dwl = mkIf (cfg.type == "dwl") {
    enable = true;
    # package =
    #   (pkgs.dwl.override {
    #     configH = ./config.h;
    #   }).overrideAttrs (oldAttrs: {
    #     buildInputs =
    #       oldAttrs.buildInputs or []
    #       ++ [
    #         pkgs.libdrm
    #         pkgs.fcft
    #       ];
    #     patches =
    #       oldAttrs.patches or []
    #       ++ [
    #         ./bar-0.7.patch
    #       ];
    #   });

    extraSessionCommands = "";
  };
}
