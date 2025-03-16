{
  lib,
  python3,
  fetchFromGitHub,
  gobject-introspection,
  wrapGAppsHook3,
  at-spi2-core,
  libwnck,
  ...
}:
python3.pkgs.buildPythonApplication {
  pname = "hints";
  version = "unstable";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "AlfredoSequeida";
    repo = "hints";
    rev = "cd406235bbd7b5b279f37a3bef0a57f63f64514e";
    hash = "sha256-bCgGUnn8LBGo0At7Zr4QYaxjvaFh3i0kUWJDCvyZfbY=";
  };

  disabled = python3.pkgs.pythonOlder "3.10";

  build-system = with python3.pkgs; [setuptools];

  dependencies = with python3.pkgs; [
    pygobject3
    pillow
    pyscreenshot
    opencv-python
    pyatspi
  ];

  nativeBuildInputs = [
    gobject-introspection
    wrapGAppsHook3
  ];

  buildInputs = [
    at-spi2-core
    libwnck # for X11
  ];

  makeWrapperArgs = ["\${gappsWrapperArgs[@]}"];

  meta = {
    description = "Navigate GUIs without a mouse by typing hints in combination with modifier keys";
    homepage = "https://github.com/AlfredoSequeida/hints";
    license = with lib.licenses; [gpl3Only];
    platforms = lib.platforms.linux;
    maintainers = [];
  };
}
