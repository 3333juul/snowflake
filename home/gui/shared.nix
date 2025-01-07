{
  lib,
  pkgs,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.garden.programs.gui.enable {
    home.packages = with pkgs; [
      bleachbit # cache cleaner
      libreoffice
      nix-prefetch-github
      pavucontrol # pulseaudio volume controle (GUI)
      qalculate-gtk # calculator
      winetricks
      wineWowPackages.wayland
      obsidian
      font-manager
      stremio
      qbittorrent
      obs-studio
      signal-desktop
      telegram-desktop
    ];
  };
}
