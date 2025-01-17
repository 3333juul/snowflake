{
  pkgs,
  stdenv,
  fetchgit,
  ...
}:
stdenv.mkDerivation {
  pname = "rofi";
  version = "1.0";

  src = fetchgit {
    url = "https://github.com/lbonn/rofi";
    rev = "0a0cc5f6d7b6d028cc7f6140edf5416d187b3696";
    hash = "sha256-R+6ChMPXARftFu9xOygQAsu8Nv53L33lBrUdfeuiqK0=";
    fetchSubmodules = true;
  };

  buildPhase = ''
    meson configure
    ninja
  '';

  installPhase = ''
    ninja install
  '';

  nativeBuildInputs = with pkgs; [
    meson
    cmake
    autoconf
    automake
    ninja
    flex
    bison
    check
    glib
    cairo
    pango
    libxkbcommon
    gdk-pixbuf
    pkg-config
    xcbutilxrm
    xcb-util-cursor
    xcb-imdkit
    xorg.xcbutilwm
    xorg.xcbutil
    xorg.xcbutilkeysyms
    libstartup_notification
    kdePackages.wayland-protocols
    wayland
    wayland-scanner
    git
    doxygen
    cppcheck

    # fix svg icons - https://github.com/NixOS/nixpkgs/pull/107156
    wrapGAppsHook

    # idk
    #librsvg

    # https://github.com/cratedev/nix-config/blob/2f406eaf6e502a346e1e4719db0606ae888c9211/home/programs/rofi-custom.nix#L6
  ];
}
