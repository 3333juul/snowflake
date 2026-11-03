{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.presets.gui;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bleachbit # cache cleaner
      file-roller # archive
      pavucontrol # gui volume control
      qalculate-gtk # calculator
      qbittorrent # torrent client
      stremio-linux-shell
      obs-studio
      signal-desktop
      ayugram-desktop
      # tor-browser

      popsicle # live-media
    ];
  };
}
