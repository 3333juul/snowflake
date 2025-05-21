{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.environment.desktop.type;

  mkScript = name: script: pkgs.writeShellScriptBin name (builtins.readFile script);

  scripts =
    (builtins.mapAttrs mkScript {
      betterpin = ./betterpin;
      browserhere = ./browserhere;
      changelayout = ./changelayout;
      closespecial = ./closespecial;
      colorpicker = ./colorpicker;
      dynamicwindow = ./dynamicwindow;
      easymotion = ./easymotion;
      focuswindow = ./focuswindow;
      groupbind-run = ./groupbind-run;
      hycov-easymotion = ./hycov-easymotion;
      hyprtabs = ./hyprtabs;
      movetospecial = ./movetospecial;
      obsidianspecial = ./obsidianspecial;
      prevclosespecial = ./prevclosespecial;
      riodraw = ./riodraw;
      screenrecord = ./screenrecord;
      screenshot = ./screenshot;
      selectwallpaper = ./selectwallpaper;
      special_per_workspace = ./special_per_workspace;
      testscript = ./testscript;
      toggleanimations = ./toggleanimations;
      togglefloating = ./togglefloating;
      togglespecial-menu = ./togglespecial-menu;
      toggleurgent = ./toggleurgent;
      toggleswallow = ./toggleswallow;
      togglewindow = ./togglewindow;
      wininfo = ./wininfo;
      windowstate = ./windowstate;

      # wallshift
      wallshift = ./wallshift/wallshift;
      killwallshift = ./wallshift/killwallshift;
      wallselect = ./wallshift/wallselect;

      # autostart
      autostart-ai = ./autostart/autostart-ai;
      autostart-dict = ./autostart/autostart-dict;
      autostart-music = ./autostart/autostart-music;
    })
    // {
      # additional scripts that don't use `mkScript`
      floatinggrid = pkgs.writers.writePython3Bin "floatinggrid" {} (
        builtins.readFile ./floatinggrid.py
      );
    };
in {
  config = mkIf (cfg == "Hyprland") {
    home.packages = builtins.attrValues scripts;
  };
}
