{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.presets.gui;

  mkScript = name: script: pkgs.writeShellScriptBin name (builtins.readFile script);

  scripts =
    (builtins.mapAttrs mkScript {
      changevolume = ./changevolume;
      confirm = ./confirm;
      fopen = ./fopen;
      git-dl = ./git-dl;
      imgv = ./imgv;
      kitty-scrollback = ./kitty-scrollback;
      launcher = ./launcher;
      man-zathura = ./man-zathura;
      ocr = ./ocr;
      organize-downloads = ./organize-downloads;
      powermenu = ./powermenu;
      quicklinks = ./quicklinks;
      repoctl = ./repoctl;
      rofi-bluetooth = ./rofi-bluetooth;
      rofi-gridview = ./rofi-gridview;
      rofi-translate = ./rofi-translate;
      s-img = ./s-img;
      yazi-dir = ./yazi-dir;
    })
    // {
      # Python-based script with specific libraries
      ocr-lookup = pkgs.writers.writePython3Bin "ocr-lookup" {
        libraries = with pkgs.python3Packages; [pytesseract pillow pyqt5 pynput];
        doCheck = false;
      } (builtins.readFile ./ocr-lookup.py);
    };
in {
  config = mkIf cfg.enable {
    home.packages = builtins.attrValues scripts;
  };
}
