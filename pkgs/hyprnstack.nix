{
  stdenv,
  fetchFromGitHub,
  pkgs,
  ...
}:
with pkgs;
  stdenv.mkDerivation rec {
    name = "hyprNStack";
    pname = name;

    src = fetchFromGitHub {
      owner = "zakk4223";
      repo = "hyprNStack";
      rev = "d9368100dc18df6fecf8cc7b9239518b5b8af733";
      hash = "sha256-/AZ5fJNr0RjwovpVvdwcGAKylwFJ+Jjcp3/FjQHjRT8=";
    };

    nativeBuildInputs = [
      pkg-config
      hyprland
    ];

    buildInputs = [hyprland] ++ hyprland.buildInputs;

    buildPhase = ''
      make all
    '';

    installPhase = ''
      mkdir -p $out/lib
      cp ./nstackLayoutPlugin.so $out/lib/libhyprNStack.so
    '';
  }
