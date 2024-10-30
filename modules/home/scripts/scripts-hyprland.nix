{pkgs, ...}: let
  betterpin = pkgs.writeShellScriptBin "betterpin" (builtins.readFile ./scripts-hyprland/betterpin);
  changelayout = pkgs.writeShellScriptBin "changelayout" (builtins.readFile ./scripts-hyprland/changelayout);
  closespecial = pkgs.writeShellScriptBin "closespecial" (builtins.readFile ./scripts-hyprland/closespecial);
  colorpicker = pkgs.writeShellScriptBin "colorpicker" (builtins.readFile ./scripts-hyprland/colorpicker);
  dynamicwindow = pkgs.writeShellScriptBin "dynamicwindow" (builtins.readFile ./scripts-hyprland/dynamicwindow);
  easymotion = pkgs.writeShellScriptBin "easymotion" (builtins.readFile ./scripts-hyprland/easymotion);
  floatinggrid = pkgs.writers.writePython3Bin "floatinggrid" {} (builtins.readFile ./scripts-hyprland/floatinggrid.py);
  focuswindow = pkgs.writeShellScriptBin "focuswindow" (builtins.readFile ./scripts-hyprland/focuswindow);
  groupbind-run = pkgs.writeShellScriptBin "groupbind-run" (builtins.readFile ./scripts-hyprland/groupbind-run);
  hycov-easymotion = pkgs.writeShellScriptBin "hycov-easymotion" (builtins.readFile ./scripts-hyprland/hycov-easymotion);
  hyprtabs = pkgs.writeShellScriptBin "hyprtabs" (builtins.readFile ./scripts-hyprland/hyprtabs);
  movetospecial = pkgs.writeShellScriptBin "movetospecial" (builtins.readFile ./scripts-hyprland/movetospecial);
  obsidianspecial = pkgs.writeShellScriptBin "obsidianspecial" (builtins.readFile ./scripts-hyprland/obsidianspecial);
  prevclosespecial = pkgs.writeShellScriptBin "prevclosespecial" (builtins.readFile ./scripts-hyprland/prevclosespecial);
  resetxdgportal = pkgs.writeShellScriptBin "resetxdgportal" (builtins.readFile ./scripts-hyprland/resetxdgportal);
  riodraw = pkgs.writeShellScriptBin "riodraw" (builtins.readFile ./scripts-hyprland/riodraw);
  screenrecord = pkgs.writeShellScriptBin "screenrecord" (builtins.readFile ./scripts-hyprland/screenrecord);
  selectwallpaper = pkgs.writeShellScriptBin "selectwallpaper" (builtins.readFile ./scripts-hyprland/selectwallpaper);
  special_per_workspace = pkgs.writeShellScriptBin "special_per_workspace" (builtins.readFile ./scripts-hyprland/special_per_workspace);
  testscript = pkgs.writeShellScriptBin "testscript" (builtins.readFile ./scripts-hyprland/testscript);
  toggleanimations = pkgs.writeShellScriptBin "toggleanimations" (builtins.readFile ./scripts-hyprland/toggleanimations);
  togglefloating = pkgs.writeShellScriptBin "togglefloating" (builtins.readFile ./scripts-hyprland/togglefloating);
  togglespecial-menu = pkgs.writeShellScriptBin "togglespecial-menu" (builtins.readFile ./scripts-hyprland/togglespecial-menu);
  toggleurgent = pkgs.writeShellScriptBin "toggleurgent" (builtins.readFile ./scripts-hyprland/toggleurgent);
  togglewindow = pkgs.writeShellScriptBin "togglewindow" (builtins.readFile ./scripts-hyprland/togglewindow);
  wininfo = pkgs.writeShellScriptBin "wininfo" (builtins.readFile ./scripts-hyprland/wininfo);
  launch-waybar = pkgs.writeShellScriptBin "launch-waybar" (builtins.readFile ./scripts-hyprland/launch-waybar);
  windowstate = pkgs.writeShellScriptBin "windowstate" (builtins.readFile ./scripts-hyprland/windowstate);

  # wallshift
  wallshift = pkgs.writeShellScriptBin "wallshift" (builtins.readFile ./scripts-hyprland/wallshift/wallshift);
  killwallshift = pkgs.writeShellScriptBin "killwallshift" (builtins.readFile ./scripts-hyprland/wallshift/killwallshift);
  wallselect = pkgs.writeShellScriptBin "wallselect" (builtins.readFile ./scripts-hyprland/wallshift/wallselect);

  # autostart
  autostart-ai = pkgs.writeShellScriptBin "autostart-ai" (builtins.readFile ./scripts-hyprland/autostart/autostart-ai);
  autostart-dict = pkgs.writeShellScriptBin "autostart-dict" (builtins.readFile ./scripts-hyprland/autostart/autostart-dict);
  autostart-music = pkgs.writeShellScriptBin "autostart-music" (builtins.readFile ./scripts-hyprland/autostart/autostart-music);
in {
  home.packages = with pkgs; [
    betterpin
    changelayout
    closespecial
    colorpicker
    dynamicwindow
    easymotion
    floatinggrid
    focuswindow
    groupbind-run
    hycov-easymotion
    hyprtabs
    movetospecial
    obsidianspecial
    prevclosespecial
    resetxdgportal
    riodraw
    screenrecord
    selectwallpaper
    special_per_workspace
    testscript
    toggleanimations
    togglefloating
    togglespecial-menu
    toggleurgent
    togglewindow
    wininfo
    launch-waybar
    windowstate

    # wallshift
    wallshift
    killwallshift
    wallselect

    # autostart
    autostart-ai
    autostart-dict
    autostart-music
  ];
}
