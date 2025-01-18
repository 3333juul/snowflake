{pkgs, ...}: let
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
      ocr-sdcv-wl = ./scripts-default/ocr-sdcv-wl;
      powermenu = ./scripts-default/powermenu;
      quicklinks = ./scripts-default/quicklinks;
      rofi-bluetooth = ./scripts-default/rofi-bluetooth;
      rofi-gridview = ./scripts-default/rofi-gridview;
      rofi-prompts = ./scripts-default/rofi-prompts;
      rofi-translate = ./scripts-default/rofi-translate;
      s-img = ./scripts-default/s-img;
      windows = ./scripts-default/windows;
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
  home.packages = builtins.attrValues scripts;
}
