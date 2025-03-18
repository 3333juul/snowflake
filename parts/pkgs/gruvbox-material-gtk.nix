{
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "gruvbox-material-gtk";
  version = "2024-08-09";

  src = fetchFromGitHub {
    owner = "TheGreatMcPain";
    repo = "gruvbox-material-gtk";
    rev = "808959bcfe8b9409b49a7f92052198f0882ae8bc";
    hash = "sha256-NHjE/HI/BJyjrRfoH9gOKIU8HsUIBPV9vyvuW12D01M=";
  };

  installPhase = ''
    mkdir -p "$out/share/themes/"
    mkdir -p "$out/share/icons/"
    cp -r './themes/Gruvbox-Material-Dark' "$out/share/themes/"
    cp -r './themes/Gruvbox-Material-Dark-HIDPI' "$out/share/themes/"
    cp -r './icons/Gruvbox-Material-Dark' "$out/share/icons/"
  '';

  dontFixup = true;

  meta = {
    homepage = "https://github.com/TheGreatMcPain/gruvbox-material-gtk";
    description = "Gruvbox Material for GTK, Gnome, Cinnamon, XFCE, Unity, Plank and Icons ";
  };
}
