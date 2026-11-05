{
  wayland.windowManager.mango = {
    settings = {
      # Scroller Layout Setting
      scroller_structs = 20;
      scroller_default_proportion = 0.8;
      scroller_focus_center = 0;
      scroller_prefer_center = 0;
      edge_scroller_pointer_focus = 1;
      scroller_default_proportion_single = 1.0;
      scroller_proportion_preset = "0.5,0.8,1.0";

      # Monocle Layout Setting
      monocle_tab_mode = 1;

      # Master-Stack Layout Setting
      new_is_master = 0;
      default_master_factor = 0.55;
      default_master_count = 1;
      smart_gaps = 0;

      # Overview Setting
      hotarea_size = 10;
      enable_hotarea = 1;
      overview_gap_inner = 5;
      overview_gap_outer = 30;

      # Misc
      no_border_when_single = 0;
      axis_bind_apply_timeout = 100;
      focus_on_activate = 1;
      idle_inhibit_ignore_visible = 0;
      sloppy_focus = 1;
      warp_cursor = 1;
      focus_cross_monitor = 0;
      focus_cross_tag = 0;
      enable_floating_snap = 0;
      snap_distance = 30;
      drag_tile_to_tile = 1;

      # Keyboard
      repeat_rate = 25;
      repeat_delay = 600;
      numlock_on = 0;
      xkb_rules_layout = "pl";
      xkb_rules_options = "caps:escape";

      # Trackpad
      # Need relogin to make it apply
      disable_trackpad = 0;
      tap_to_click = 1;
      tap_and_drag = 1;
      drag_lock = 1;
      trackpad_natural_scrolling = 0;
      trackpad_disable_while_typing = 1;
      trackpad_left_handed = 0;
      trackpad_middle_button_emulation = 0;
      swipe_min_threshold = 1;

      # Mouse
      # Need relogin to make it apply
      mouse_natural_scrolling = 0;
    };
  };
}
