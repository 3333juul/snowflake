{
  wayland.windowManager.mango = {
    settings = ''
      # monitor rules
      monitorrule=eDP-1,0.55,1,tile,0,1,0,0,1920,1080,60
      monitorrule=HDMI-A-1,0.55,1,tile,0,1,1920,0,1920,1080,60

      # tag rules
      # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
      tagrule=id:1,layout_name:tile
      tagrule=id:2,layout_name:tile
      tagrule=id:3,layout_name:tile
      tagrule=id:4,layout_name:tile
      tagrule=id:5,layout_name:tile
      tagrule=id:6,layout_name:tile
      tagrule=id:7,layout_name:tile
      tagrule=id:8,layout_name:tile
      tagrule=id:9,layout_name:tile

      #window rules
      windowrule=isnamedscratchpad:1,width:1532,height:809,appid:spotify

      # layer rules
      layerrule=animation_type_open:zoom,layer_name:rofi
      layerrule=animation_type_close:zoom,layer_name:rofi
    '';
  };
}
