{
  wayland.windowManager.mango = {
    settings = {
      # Monitor rules
      monitorrule = [
        "eDP-1,0.55,1,tile,0,1,0,0,1920,1080,60"
        "HDMI-A-1,0.55,1,tile,0,1,1920,0,1920,1080,60"
      ];

      # Tag rules
      # tile, scroller, grid, deck, monocle, center_tile,
      # vertical_tile, vertical_scroller
      tagrule = [
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
      windowrule = [
        "isnamedscratchpad:1,width:1532,height:809,appid:spotify"
      ];

      # Layer rules
      layerrule = [
        "animation_type_open:zoom,layer_name:rofi"
        "animation_type_close:zoom,layer_name:rofi"
      ];
    };
  };
}
