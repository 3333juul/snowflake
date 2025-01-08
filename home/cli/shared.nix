{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs;
in {
  config = mkIf cfg.cli.enable {
    home.packages = with pkgs; [
      ## CLI utility
      appimage-run # run appimage
      cliphist # clipboard manager
      eza # ls replacement
      entr # perform action when file change
      fd # find replacement
      ffmpeg
      file # Show file information
      translate-shell # translate
      gtrash # rm replacement, put deleted files in system trash
      hexdump
      killall
      libnotify
      man-pages # extra man pages
      ncdu # disk space
      openssl
      onefetch # fetch utility for git repo
      pamixer # pulseaudio command line mixer
      pulsemixer
      playerctl # controller for media players
      poweralertd
      programmer-calculator
      ripgrep # grep replacement
      tldr
      unzip
      wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
      yt-dlp-light
      xdg-utils
      jq
      jless
      socat
      imagemagick
      ripdrag
      sptlrx
      tty-clock # cli clock
    ];
  };
}
