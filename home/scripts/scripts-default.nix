{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.gui;

  mkScript = name: script: pkgs.writeShellScriptBin name (builtins.readFile script);

  scripts =
    (builtins.mapAttrs mkScript {
      changevolume = ./scripts-default/changevolume;
      confirm = ./scripts-default/confirm;
      fopen = ./scripts-default/fopen;
      git-dl = ./scripts-default/git-dl;
      imgv = ./scripts-default/imgv;
      kitty-scrollback = ./scripts-default/kitty-scrollback;
      launcher = ./scripts-default/launcher;
      man-zathura = ./scripts-default/man-zathura;
      ocr = ./scripts-default/ocr;
      organize-downloads = ./scripts-default/organize-downloads;
      powermenu = ./scripts-default/powermenu;
      quicklinks = ./scripts-default/quicklinks;
      repoctl = ./scripts-default/repoctl;
      rofi-bluetooth = ./scripts-default/rofi-bluetooth;
      rofi-gridview = ./scripts-default/rofi-gridview;
      rofi-translate = ./scripts-default/rofi-translate;
      s-img = ./scripts-default/s-img;
      yazi-dir = ./scripts-default/yazi-dir;
    })
    // {
      # Python-based script with specific libraries
      ocr-lookup = pkgs.writers.writePython3Bin "ocr-lookup" {
        libraries = with pkgs.python3Packages; [pytesseract pillow pyqt5 pynput];
        doCheck = false;
      } (builtins.readFile ./scripts-default/ocr-lookup.py);
    };
in {
  config = mkIf cfg.enable {
    home.packages = builtins.attrValues scripts;
  };
}
