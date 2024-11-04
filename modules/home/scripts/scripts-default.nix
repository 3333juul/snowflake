{pkgs, ...}: let
  changevolume = pkgs.writeShellScriptBin "changevolume" (builtins.readFile ./scripts-default/changevolume);
  confirm = pkgs.writeShellScriptBin "confirm" (builtins.readFile ./scripts-default/confirm);
  fopen = pkgs.writeShellScriptBin "fopen" (builtins.readFile ./scripts-default/fopen);
  kitty-scrollback = pkgs.writeShellScriptBin "kitty-scrollback" (builtins.readFile ./scripts-default/kitty-scrollback);
  launcher = pkgs.writeShellScriptBin "launcher" (builtins.readFile ./scripts-default/launcher);
  man-zathura = pkgs.writeShellScriptBin "man-zathura" (builtins.readFile ./scripts-default/man-zathura);
  ocr = pkgs.writeShellScriptBin "ocr" (builtins.readFile ./scripts-default/ocr);
  ocr-sdcv-wl = pkgs.writeShellScriptBin "ocr-sdcv-wl" (builtins.readFile ./scripts-default/ocr-sdcv-wl);
  powermenu = pkgs.writeShellScriptBin "powermenu" (builtins.readFile ./scripts-default/powermenu);
  quicklinks = pkgs.writeShellScriptBin "quicklinks" (builtins.readFile ./scripts-default/quicklinks);
  rofi-bluetooth = pkgs.writeShellScriptBin "rofi-bluetooth" (builtins.readFile ./scripts-default/rofi-bluetooth);
  rofi-prompts = pkgs.writeShellScriptBin "rofi-prompts" (builtins.readFile ./scripts-default/rofi-prompts);
  rofi-translate = pkgs.writeShellScriptBin "rofi-translate" (builtins.readFile ./scripts-default/rofi-translate);
  screenshot-wl = pkgs.writeShellScriptBin "screenshot-wl" (builtins.readFile ./scripts-default/screenshot-wl);
  sig = pkgs.writeShellScriptBin "sig" (builtins.readFile ./scripts-default/sig);
  s-img = pkgs.writeShellScriptBin "s-img" (builtins.readFile ./scripts-default/s-img);
  windows = pkgs.writeShellScriptBin "windows" (builtins.readFile ./scripts-default/windows);
in {
  home.packages = with pkgs; [
    changevolume
    confirm
    fopen
    kitty-scrollback
    launcher
    man-zathura
    ocr
    ocr-sdcv-wl
    powermenu
    quicklinks
    rofi-bluetooth
    rofi-prompts
    rofi-translate
    screenshot-wl
    sig
    s-img
    windows
  ];
}
