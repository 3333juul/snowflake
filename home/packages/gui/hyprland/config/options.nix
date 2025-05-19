{
  osConfig,
  lib,
  ...
}: let
  inherit (lib.attrsets) mapAttrsToList;

  dev = osConfig.garden.device;
  cfg = osConfig.garden.environment.desktop.hyprland;
  monitorList = mapAttrsToList (name: conf: "${name},${conf}") cfg.monitors;
in {
  wayland.windowManager.hyprland.settings = {
    monitor = monitorList;

    general = {
      "$mainMod" = "SUPER";
      inherit (cfg) layout;
      resize_on_border = true;
      no_border_on_floating = false;
      #snap = {
      #  enabled = true;
      #  border_overlap = true;
      #};
    };

    input = {
      kb_layout = dev.keyboard;
      kb_options = "caps:swapescape";
      numlock_by_default = false;
      follow_mouse = 1;
      float_switch_override_focus = 0;
      mouse_refocus = 0;
      sensitivity = 0;
      touchpad = {
        natural_scroll = true;
      };
      natural_scroll = false;
    };

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      focus_on_activate = false;
      new_window_takes_over_fullscreen = 1;
      #initial_workspace_tracking = 0;
      enable_swallow = false;
      swallow_regex = "kitty";
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
    };

    binds = {
      allow_workspace_cycles = true;
      hide_special_on_workspace_change = true;
    };

    master = {
      allow_small_split = true;
      #no_gaps_when_only = 2
    };
  };
}
