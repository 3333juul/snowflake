{
  lib,
  fetchFromGitHub,
  gitUpdater,
  gtk3,
  libxkbcommon,
  meson,
  ninja,
  opencv,
  pkg-config,
  stdenv,
  wayland,
  wayland-protocols,
  wayland-scanner,
}: let
  pname = "wl-kbptr";
  version = "0.3.0";
in
  stdenv.mkDerivation {
    inherit pname version;
    src = fetchFromGitHub {
      owner = "moverest";
      repo = "wl-kbptr";
      tag = "0c67f640028fe0ded8d0460f69285bc1f34ff86e";
      hash = "sha256-KhQGcaoAiuSBJmcIajbqtuiECHRQXZ0eYPMna6BV3Pw=";
    };

    depsBuildBuild = [pkg-config];

    nativeBuildInputs = [
      meson
      ninja
      pkg-config
      wayland-scanner
    ];

    buildInputs = [
      gtk3
      libxkbcommon
      wayland
      wayland-protocols
      opencv
    ];

    strictDeps = true;

    mesonFlags = ["-Dopencv=enabled"];

    passthru = {
      updateScript = gitUpdater {};
    };

    meta = {
      homepage = "https://github.com/moverest/wl-kbptr";
      description = "Control the mouse pointer with the keyboard on Wayland";
      changelog = "https://github.com/moverest/wl-kbptr/releases/tag/v${version}";
      license = lib.licenses.gpl3;
      mainProgram = "wl-kbptr";
      maintainers = [lib.maintainers.luftmensch-luftmensch];
      inherit (wayland.meta) platforms;
    };
  }
