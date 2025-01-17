{
  lib,
  pkgs,
  python3,
  fetchFromGitHub,
  python3Packages,
  gst_all_1,
}: let
  pyqtdarktheme-fork = python3Packages.pyqtdarktheme.overridePythonAttrs (_: {
    pname = "pyqtdarktheme";
    version = "2.3.2";
    src = fetchFromGitHub {
      owner = "henriquegemignani";
      repo = "PyQtDarkTheme";
      rev = "4715e906f005bf70f19bc4f1f4dc4cf7d08c175a";
      sha256 = "sha256-3pdwqhrJiZk/NM7XoE4EGhd7wUCWiXBu9/Nc/tekqcI=";
    };
  });
in
  python3.pkgs.buildPythonApplication rec {
    pname = "vocabsieve";
    version = "0.12.4";
    format = "pyproject";

    src = fetchFromGitHub {
      owner = "FreeLanguageTools";
      repo = pname;
      rev = "v${version}";
      hash = "sha256-LTu/3I4blP72CaZo6o3fTDoufK9QNtSjE5umfvEpwAE=";
    };

    nativeBuildInputs = [
      pkgs.qt5.wrapQtAppsHook
      gst_all_1.gst-libav
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-vaapi
      gst_all_1.gstreamer
    ];

    preFixup = ''
      makeWrapperArgs+=("''${qtWrapperArgs[@]}")
      makeWrapperArgs+=(--prefix GST_PLUGIN_SYSTEM_PATH_1_0 : "$GST_PLUGIN_SYSTEM_PATH_1_0")
    '';

    buildInputs = [
      pkgs.qt5.qtbase
      pkgs.qt5.qtmultimedia
      python3Packages.setuptools
    ];

    propagatedBuildInputs = with python3Packages; [
      bidict
      ebooklib
      flask
      flask-sqlalchemy
      lxml
      markdown
      markdownify
      mobi
      packaging
      pynput
      pymorphy3
      pymorphy3-dicts-ru
      pymorphy3-dicts-uk
      pyqt5-multimedia
      pyqtgraph
      pyqtdarktheme-fork
      pysubs2
      pystardict
      python-lzo
      readmdict
      requests
      sentence-splitter
      simplemma
      slpp
      waitress
    ];

    meta = with lib; {
      description = "Simple sentence mining tool for language learning";
      homepage = "https://github.com/FreeLanguageTools/vocabsieve";
      license = licenses.gpl3;
      maintainers = [maintainers.rasmusrendal];
    };
  }
