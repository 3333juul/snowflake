{
  pkgs,
  inputs,
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals concatLists;
  inherit (lib.options) mkEnableOption;
  inherit (osConfig.garden.device) hasTouchscreen;

  cfg = config.garden.environment.desktop.hyprland.plugins;
in {
  options.garden.environment.desktop.hyprland.plugins = {
    hycov.enable = mkEnableOption {} // {default = false;};
    hyprNStack.enable = mkEnableOption {} // {default = false;};
    hyprgrass.enable = mkEnableOption {} // {default = false;};
    hyprland-easymotion.enable = mkEnableOption {} // {default = false;};
  };

  config.wayland.windowManager.hyprland = {
    plugins = concatLists [
      (optionals cfg.hycov.enable [
        inputs.hycov.packages.${pkgs.system}.hycov
      ])

      (optionals cfg.hyprNStack.enable [
        inputs.self.packages.${pkgs.system}.hyprNStack
      ])

      (optionals cfg.hyprland-easymotion.enable [
        inputs.hyprland-easymotion.packages.${pkgs.system}.hyprland-easymotion
      ])

      (optionals (cfg.hyprgrass.enable && hasTouchscreen) [
        inputs.hyprgrass.packages.${pkgs.system}.default
      ])
    ];

    settings.plugin = {
      easymotion = mkIf cfg.hyprland-easymotion.enable {
        textsize = 30;
        textcolor = "rgb(ebdbb2)";
        bgcolor = "rgba(40,40,40,1)";
        textfont = "Terminus";
        textpadding = "8,16,8,16";
        bordersize = 1;
        bordercolor = "rgb(ebdbb2)";
        rounding = 0;
        motionkeys = "jkhluiopynmbfdsatgrvcewqzx1234567890";
      };

      hycov = mkIf cfg.hycov.enable {
        overview_gappo = 60;
        overview_gappi = 24;
        enable_hotarea = 0;
        hotarea_monitor = "all";
        hotarea_pos = 1;
        hotarea_size = 10;
        swipe_fingers = 4;
        move_focus_distance = 100;
        enable_gesture = 0;
        auto_exit = 1;
        auto_fullscreen = 0;
        only_active_workspace = 0;
        only_active_monitor = 0;
        enable_alt_release_exit = 0;
        alt_replace_key = "Alt_L";
        alt_toggle_auto_next = 0;
        click_in_cursor = 1;
        hight_of_titlebar = 0;
        show_special = 0;
      };

      nstack = mkIf cfg.hyprNStack.enable {
        layout = {
          orientation = "left";
          new_on_top = 0;
          new_is_master = 0;
          no_gaps_when_only = -1;
          special_scale_factor = 0;
          inherit_fullscreen = 1;
          stacks = 4;
          center_single_master = 0;
          mfact = 0;
          single_mfact = 0;
          orientationvcenter = "bottom";
        };
      };
    };
  };
}
