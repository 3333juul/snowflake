{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.programs.gui;
in {
  config = lib.mkIf cfg.zotero.enable {
    home.packages = with pkgs; [
      zotero
    ];
  };
}
