{
  inputs,
  pkgs,
  ...
}: let
  vocabsieve = pkgs.callPackage ../../pkgs/vocabsieve.nix {};
in {
  home.packages = with pkgs; [
    vocabsieve

    # Thumbnailers
    ffmpegthumbnailer
    gdk-pixbuf

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
