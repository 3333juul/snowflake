{pkgs, ...}: let
  changevolume = pkgs.writeShellScriptBin "changevolume" (builtins.readFile ./scripts-default/changevolume);
  confirm = pkgs.writeShellScriptBin "confirm" (builtins.readFile ./scripts-default/confirm);
  fopen = pkgs.writeShellScriptBin "fopen" (builtins.readFile ./scripts-default/fopen);
  git-dl = pkgs.writeShellScriptBin "git-dl" (builtins.readFile ./scripts-default/git-dl);
  imgv = pkgs.writeShellScriptBin "imgv" (builtins.readFile ./scripts-default/imgv);
  kitty-scrollback = pkgs.writeShellScriptBin "kitty-scrollback" (builtins.readFile ./scripts-default/kitty-scrollback);
  launcher = pkgs.writeShellScriptBin "launcher" (builtins.readFile ./scripts-default/launcher);
  man-zathura = pkgs.writeShellScriptBin "man-zathura" (builtins.readFile ./scripts-default/man-zathura);
  ocr = pkgs.writeShellScriptBin "ocr" (builtins.readFile ./scripts-default/ocr);
  ocr-sdcv-wl = pkgs.writeShellScriptBin "ocr-sdcv-wl" (builtins.readFile ./scripts-default/ocr-sdcv-wl);
  powermenu = pkgs.writeShellScriptBin "powermenu" (builtins.readFile ./scripts-default/powermenu);
  quicklinks = pkgs.writeShellScriptBin "quicklinks" (builtins.readFile ./scripts-default/quicklinks);
  rofi-bluetooth = pkgs.writeShellScriptBin "rofi-bluetooth" (builtins.readFile ./scripts-default/rofi-bluetooth);
  rofi-gridview = pkgs.writeShellScriptBin "rofi-gridview" (builtins.readFile ./scripts-default/rofi-gridview);
  rofi-prompts = pkgs.writeShellScriptBin "rofi-prompts" (builtins.readFile ./scripts-default/rofi-prompts);
  rofi-translate = pkgs.writeShellScriptBin "rofi-translate" (builtins.readFile ./scripts-default/rofi-translate);
  s-img = pkgs.writeShellScriptBin "s-img" (builtins.readFile ./scripts-default/s-img);
  windows = pkgs.writeShellScriptBin "windows" (builtins.readFile ./scripts-default/windows);
  yazi-dir = pkgs.writeShellScriptBin "yazi-dir" (builtins.readFile ./scripts-default/yazi-dir);

  # python
  ocr-lookup = pkgs.writers.writePython3Bin "ocr-lookup" {
    libraries = with pkgs.python3Packages; [pytesseract pillow pyqt5 pynput];
    doCheck = false;
  } (builtins.readFile ./scripts-default/ocr-lookup.py);
in {
  home.packages = with pkgs; [
    changevolume
    confirm
    fopen
    git-dl
    imgv
    kitty-scrollback
    launcher
    man-zathura
    ocr
    ocr-sdcv-wl
    powermenu
    quicklinks
    rofi-bluetooth
    rofi-gridview
    rofi-prompts
    rofi-translate
    s-img
    windows
    yazi-dir

    ocr-lookup
  ];
}
