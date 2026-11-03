{
  wayland.windowManager.mango = {
    settings = {
      # Window effect
      blur = 0;
      blur_layer = 0;
      blur_optimized = 1;
      blur_params_num_passes = 2;
      blur_params_radius = 5;
      blur_params_noise = 0.02;
      blur_params_brightness = 0.9;
      blur_params_contrast = 0.9;
      blur_params_saturation = 1.2;

      shadows = 0;
      layer_shadows = 0;
      shadow_only_floating = 1;
      shadows_size = 10;
      shadows_blur = 15;
      shadows_position_x = 0;
      shadows_position_y = 0;
      shadows_color = "0x000000ff";

      border_radius = 0;
      no_radius_when_single = 0;
      focused_opacity = 1.0;
      unfocused_opacity = 1.0;

      # Appearance
      gap_inner_horizontal = 5;
      gap_inner_vertical = 5;
      gap_outer_horizontal = 10;
      gap_outer_vertical = 10;
      scratchpad_width_ratio = 0.8;
      scratchpad_height_ratio = 0.9;
      border_px = 4;

      root_color = "0x201b14ff";
      border_color = "0x444444ff";
      focus_color = "0xc9b890ff";
      maximized_screen_color = "0x89aa61ff";
      urgent_color = "0xad401fff";
      scratchpad_color = "0x516c93ff";
      global_color = "0xb153a7ff";
      overlay_color = "0x14a57cff";
    };
  };
}
