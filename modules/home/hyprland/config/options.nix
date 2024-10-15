{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,1920x1080@60,0x0,1"
      "DVI-D-1,1920x1080@60,1920x0,1"
    ];

    general = {
      "$mainMod" = "SUPER";
      layout = "master";
      resize_on_border = true;
      border_part_of_window = false;
      no_border_on_floating = false;
    };

    input = {
      kb_layout = "pl";
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
      #enable_swallow = true;
      #swallow_regex = kitty;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
    };

    binds = {
      allow_workspace_cycles = true;
    };

    master = {
      allow_small_split = true;
      #no_gaps_when_only = 2
    };
  };
}
