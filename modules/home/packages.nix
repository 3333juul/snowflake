{
  inputs,
  pkgs,
  ...
}: let
  vocabsieve = pkgs.callPackage ../../pkgs/vocabsieve.nix {};
in {
  home.packages = with pkgs; [
    vocabsieve

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
    mpv # video player
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
    wget
    yt-dlp-light
    xdg-utils
    jq
    jless
    socat
    imagemagick
    ripdrag
    sptlrx

    # Thumbnailers
    ffmpegthumbnailer
    gdk-pixbuf

    ## CLI
    tty-clock # cli clock

    ## GUI Apps
    bleachbit # cache cleaner
    gimp
    libreoffice
    nix-prefetch-github
    pavucontrol # pulseaudio volume controle (GUI)
    qalculate-gtk # calculator
    winetricks
    wineWowPackages.wayland
    zenity
    obsidian
    calibre
    zotero
    font-manager
    anki-bin
    stremio
    qbittorrent
    obs-studio
    signal-desktop
    pinta

    # C / C++
    gcc
    gdb
    gnumake

    # Python

    (python3.withPackages (ps:
      with ps; [
        pytesseract
        pyqt5
        pynput
        numpy
      ]))

    inputs.alejandra.defaultPackage.${system}

    # unused
    #gtt                               # google translate TUI
    #audacity
    #soundwireserver                   # pass audio to android phone
    #ani-cli
    #bitwise                           # cli tool for bit / hex manipulation
    #caligula                          # User-friendly, lightweight TUI for disk imaging
    #gifsicle                          # gif utility
    #nitch                             # systhem fetch util
    #qview                             # minimal image viewer
    #valgrind                          # c memory analyzer
    #todo                              # cli todo list
    #toipe                             # typing test in the terminal
    #ttyper                            # cli typing test
    #tdf                               # cli pdf viewer
    #xxd
    #cbonsai                           # terminal screensaver
    #cmatrix
    #pipes                             # terminal screensaver
    #sl
    #vlc
  ];
}
