{
  wayland.windowManager.mango = {
    settings = {
      # Monitor rules
      monitor_rule = [
        "name:^eDP-1$,width:1920,height:1080,refresh:60,x:0,y:0"
        "name:^HDMI-A-1$,width:1920,height:1080,refresh:60,x:1920,y:0"
      ];

      # Tag rules
      # tile, scroller, grid, deck, monocle, center_tile,
      # vertical_tile, vertical_scroller
      tag_rule = [
        "id:1,layout_name:tile"
        "id:2,layout_name:tile"
        "id:3,layout_name:tile"
        "id:4,layout_name:tile"
        "id:5,layout_name:tile"
        "id:6,layout_name:tile"
        "id:7,layout_name:tile"
        "id:8,layout_name:tile"
        "id:9,layout_name:tile"
      ];

      # Window rules
      window_rule = [
        "is_named_scratchpad:1,width:1532,height:809,app_id:spotify"
      ];

      # Layer rules
      layer_rule = [
        # wl-kbptr uses the selection layer namespace (also used by slurp).
        "layer_name:^selection$,no_animation:1,no_blur:1"
        "animation_type_open:zoom,layer_name:rofi"
        "animation_type_close:zoom,layer_name:rofi"
      ];

      device_rule = ["name:UGREEN Mouse,natural_scrolling:1"];
    };
  };
}
