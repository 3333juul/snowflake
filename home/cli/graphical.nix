{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig) garden;

  prg = garden.programs;
  dev = garden.device;
  acceptedTypes = ["desktop" "laptop" "lite" "hybrid"];
in {
  config = mkIf ((builtins.elem dev.type acceptedTypes) && prg.cli.enable) {
    home.packages = with pkgs; [
      appimage-run # run appimage
      brightnessctl # brightness managed via cli
      cliphist # clipboard manager
      ffmpeg
      translate-shell # translate
      trash-cli # rm replacement, put deleted files in system trash
      grim
      libnotify
      onefetch # fetch utility for git repo
      pamixer # pulseaudio command line mixer
      pulsemixer
      playerctl # controller for media players
      poweralertd
      programmer-calculator
      tesseract
      wf-recorder
      wl-clipboard # clipboard utils for wayland (wl-copy, wl-paste)
      yt-dlp-light
      xdg-utils
      jless
      socat
      slurp
      imagemagick
      ripdrag
      sptlrx
      tty-clock # cli clock
      nix-prefetch-github
    ];
  };
}
