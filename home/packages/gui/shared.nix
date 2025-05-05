{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.gui;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bleachbit # cache cleaner
      evince # pdf
      file-roller # archive
      pavucontrol # gui volume control
      qalculate-gtk # calculator
      qbittorrent # torrent client
      stremio
      obs-studio
      signal-desktop
      ayugram-desktop
    ];
  };
}
