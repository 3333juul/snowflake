{
  wayland.windowManager.mango = {
    settings = {
      # Animation configuration (supported types: zoom, slide, fade, none)
      # tag_animation_direction: 0 - horizontal, 1 - vertical
      animations = 1;
      layer_animations = 1;
      animation_type_open = "slide";
      animation_type_close = "slide";
      animation_fade_in = 1;
      animation_fade_out = 1;
      tag_animation_direction = 1;
      zoom_initial_ratio = 0.3;
      zoom_end_ratio = 0.8;
      fade_in_begin_opacity = 0.5;
      fade_out_begin_opacity = 0.8;

      animation_duration_move = 250;
      animation_duration_open = 200;
      animation_duration_tag = 175;
      animation_duration_close = 400;
      animation_duration_focus = 0;

      animation_curve_open = "0.46,1.0,0.29,1";
      animation_curve_move = "0.46,1.0,0.29,1";
      animation_curve_tag = "0.46,1.0,0.29,1";
      animation_curve_close = "0.08,0.92,0,1";
      animation_curve_focus = "0.46,1.0,0.29,1";
      animation_curve_opacity_fade_out = "0.5,0.5,0.5,0.5";
      animation_curve_opacity_fade_in = "0.46,1.0,0.29,1";
    };
  };
}
