{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.lists) optionals concatLists;
  inherit (lib.validators) hasProfile;

  cfg = osConfig.garden.presets;
in {
  home.packages = with pkgs;
    concatLists [
      (optionals cfg.cli.enable [
        cocogitto # git helpers
        eza # ls replacement
        entr # perform action when file change
        fd # find replacement
        file # Show file information
        killall
        ncdu # disk space
        ripgrep # grep replacement
        tldr
        unzip
        jq
        python3

        # nix tools
        nix-prefetch-github
        nix-output-monitor
        nvd
      ])

      (optionals (cfg.cli.enable && hasProfile osConfig ["graphical"]) [
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

        dotool
      ])
    ];
}
