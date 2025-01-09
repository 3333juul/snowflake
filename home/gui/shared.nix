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
      pavucontrol # pulseaudio volume controle (GUI)
      qalculate-gtk # calculator
      obsidian
      font-manager
      stremio
      qbittorrent
      obs-studio
      signal-desktop
      telegram-desktop
      evince # pdf
      file-roller # archive
    ];
  };
}
