{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.reading;
in {
  config = mkIf cfg.zotero.enable {
    home.packages = with pkgs; [
      zotero
    ];
  };
}
