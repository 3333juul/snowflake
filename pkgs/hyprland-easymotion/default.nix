{
  stdenv,
  fetchFromGitHub,
  pkgs,
  ...
}:
stdenv.mkDerivation {
  pname = "hypreasymotion";

  src = fetchFromGitHub {
    owner = "zakk4223";
    repo = "hyprland-easymotion";
    rev = "8ddca640080efbb3d60c76bceb7eafd5b15525c7";
    hash = "sha256-0KxcKsc/PviyKJRxd4LMOP+7xQxvc+2mAobj6r77srw=";
  };

  nativeBuildInputs = with pkgs; [
    pkg-config
    hyprland
  ];

  buildInputs = with pkgs; [hyprland] ++ hyprland.buildInputs;

  buildPhase = ''
    make all
  '';

  installPhase = ''
    mkdir -p $out/lib
    cp ./hypreasymotion.so $out/lib/libhypreasymotion.so
  '';
}
# https://github.com/tschwemley/nixos-config/blob/c39f8958975cd0cd43baae3dc9b5b6332a050fb7/packages/hyprlandPlugins/default.nix#L9

