{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
  ...
}:
buildNpmPackage {
  pname = "stremio-letterboxd";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "megadrive";
    repo = "stremio-letterboxd";
    rev = "a69e74f0f3841d17da83c239e25745b2071612c9";
    hash = "sha256-GQy3zN8RuAa0VEU9rGUbAZoImig6kypmOCznmTr6L3g=";
  };

  npmDepsHash = "sha256-wAyxW+TsSk1OBXX4f0XiYOzssHqztiz9LQZ8iCps2oQ=";

  buildPhase = ''
    npm run build
  '';

  installPhase = ''
    runHook preInstall
    cp -r . $out
    runHook postInstall
  '';

  meta = {
    description = "Stremio addon for Letterboxd integration";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [maintainer];
  };
}
