{
  lib,
  pkgs,
  ...
}:
pkgs.python311Packages.buildPythonPackage rec {
  pname = "vocabsieve";
  version = "0.12.2";
  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "1440e1682b0ba57312abf552cf7ee821a5013901887108ddbd7a58a3f7774c94";
  };
  format = "wheel";
  nativeBuildInputs = [
    pkgs.python311Packages.setuptools
    pkgs.python311Packages.wheel
    pkgs.python311Packages.build
    pkgs.python311Packages.installer
    pkgs.libsForQt5.qt5.wrapQtAppsHook
  ];
  buildInputs = [
    pkgs.qt5.qtbase
    pkgs.qt5.qtwayland
  ];
  propagatedBuildInputs = with pkgs.python311Packages; [
    beautifulsoup4
    bidict
    charset-normalizer
    ebooklib
    flask
    loguru
    lxml
    markdown
    markdownify
    mobi
    packaging
    pymorphy3
    pymorphy3-dicts-ru
    pymorphy3-dicts-uk
    pynput
    pyqt5-multimedia
    pyqtdarktheme
    pyqtgraph
    pystardict
    pysubs2
    python-lzo
    readmdict
    requests
    sentence-splitter
    simplemma
    slpp
    typing-extensions
    waitress
  ];
  dontWrapQtApps = true;
  preFixup = ''
    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
  '';
  doCheck = false;
  unpackPhase = ''
    tar -xzf ${src} -C $TMPDIR
  '';
  buildPhase = ''
    cd $TMPDIR/vocabsieve-0.12.2
    python3 -m build --wheel --no-isolation --outdir=dist
  '';
  installPhase = ''
    runHook preInstall
    cd $TMPDIR/vocabsieve-0.12.2
    python3 -m installer dist/*.whl --prefix=$out
    runHook postInstall
  '';
  postInstall = ''
    mkdir -p $out/share/applications
    cp $TMPDIR/vocabsieve-0.12.2/vocabsieve.desktop $out/share/applications
    mkdir -p $out/share/icons
    cp $TMPDIR/vocabsieve-0.12.2/vocabsieve.png $out/share/icons
  '';
  meta = with lib; {
    description = "A simple, effective sentence mining tool";
    homepage = "https://github.com/FreeLanguageTools/vocabsieve";
    license = licenses.gpl3Plus;
    maintainers = [];
  };
}
