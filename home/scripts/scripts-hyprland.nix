{pkgs, ...}: let
  mkScript = name: script: pkgs.writeShellScriptBin name (builtins.readFile script);

  scripts =
    (builtins.mapAttrs mkScript {
      betterpin = ./scripts-hyprland/betterpin;
      browserhere = ./scripts-hyprland/browserhere;
      changelayout = ./scripts-hyprland/changelayout;
      closespecial = ./scripts-hyprland/closespecial;
      colorpicker = ./scripts-hyprland/colorpicker;
      dynamicwindow = ./scripts-hyprland/dynamicwindow;
      easymotion = ./scripts-hyprland/easymotion;
      focuswindow = ./scripts-hyprland/focuswindow;
      groupbind-run = ./scripts-hyprland/groupbind-run;
      hycov-easymotion = ./scripts-hyprland/hycov-easymotion;
      hyprtabs = ./scripts-hyprland/hyprtabs;
      movetospecial = ./scripts-hyprland/movetospecial;
      obsidianspecial = ./scripts-hyprland/obsidianspecial;
      prevclosespecial = ./scripts-hyprland/prevclosespecial;
      resetxdgportal = ./scripts-hyprland/resetxdgportal;
      riodraw = ./scripts-hyprland/riodraw;
      screenrecord = ./scripts-hyprland/screenrecord;
      screenshot = ./scripts-hyprland/screenshot;
      selectwallpaper = ./scripts-hyprland/selectwallpaper;
      special_per_workspace = ./scripts-hyprland/special_per_workspace;
      testscript = ./scripts-hyprland/testscript;
      toggleanimations = ./scripts-hyprland/toggleanimations;
      togglefloating = ./scripts-hyprland/togglefloating;
      togglespecial-menu = ./scripts-hyprland/togglespecial-menu;
      toggleurgent = ./scripts-hyprland/toggleurgent;
      toggleswallow = ./scripts-hyprland/toggleswallow;
      togglewindow = ./scripts-hyprland/togglewindow;
      wininfo = ./scripts-hyprland/wininfo;
      launch-waybar = ./scripts-hyprland/launch-waybar;
      windowstate = ./scripts-hyprland/windowstate;

      # wallshift
      wallshift = ./scripts-hyprland/wallshift/wallshift;
      killwallshift = ./scripts-hyprland/wallshift/killwallshift;
      wallselect = ./scripts-hyprland/wallshift/wallselect;

      # autostart
      autostart-ai = ./scripts-hyprland/autostart/autostart-ai;
      autostart-dict = ./scripts-hyprland/autostart/autostart-dict;
      autostart-music = ./scripts-hyprland/autostart/autostart-music;
    })
    // {
      # additional scripts that don't use `mkScript`
      floatinggrid = pkgs.writers.writePython3Bin "floatinggrid" {} (
        builtins.readFile ./scripts-hyprland/floatinggrid.py
      );
    };
in {
  home.packages = builtins.attrValues scripts;
}
