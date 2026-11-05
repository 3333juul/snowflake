{osConfig, ...}: let
  inherit (osConfig.garden.style) colors;

  # Mango colors are written as 0xRRGGBBAA
  hex = name: alpha: "0x${colors.${name}}${alpha}";
in {
  wayland.windowManager.mango = {
    settings = {
      # Window effects
      blur = 1;
      blur_layer = 1;
      blur_optimized = 1;
      blur_params_num_passes = 6;
      blur_params_radius = 10;
      blur_params_noise = 0.3;
      blur_params_brightness = 1.0;
      blur_params_contrast = 1.0;
      blur_params_saturation = 1.0;

      shadows = 0;
      layer_shadows = 0;
      shadow_only_floating = 1;
      shadows_size = 10;
      shadows_blur = 15;
      shadows_position_x = 0;
      shadows_position_y = 0;
      shadows_color = "0x000000ff";

      # No rounded corners anywhere
      border_radius = 0;
      no_radius_when_single = 0;
      focused_opacity = 1.0;
      unfocused_opacity = 1.0;

      # Dimensions
      gap_inner_horizontal = 5;
      gap_inner_vertical = 5;
      gap_outer_horizontal = 10;
      gap_outer_vertical = 10;
      scratchpad_width_ratio = 0.8;
      scratchpad_height_ratio = 0.9;
      border_px = 4;

      # Gruvbox colors
      root_color = hex "base00" "ff";
      border_color = hex "base01" "ff";
      drop_color = hex "base0B" "55";
      split_color = hex "base09" "ff";
      focus_color = hex "base06" "ff";
      urgent_color = hex "base08" "ff";

      # State-specific colors
      maximized_screen_color = hex "base0B" "ff";
      scratchpad_color = hex "base0D" "ff";
      global_color = hex "base0E" "ff";
      overlay_color = hex "base0C" "ff";

      # Overview jump labels
      jump_label_decorate_fg_color = hex "base05" "ff";
      jump_label_decorate_bg_color = hex "base00" "ff";
      jump_label_decorate_focus_fg_color = hex "base06" "ff";
      jump_label_decorate_focus_bg_color = hex "base02" "ff";
      jump_label_decorate_border_color = hex "base0D" "ff";
      jump_label_decorate_border_width = 4;
      jump_label_decorate_corner_radius = 0;
      jump_label_decorate_padding_x = 10;
      jump_label_decorate_padding_y = 10;
      jump_label_decorate_font_desc = "Terminess Nerd Font Bold 16";

      # Group bar
      always_show_group_bar = 0;
      group_bar_height = 24;
      group_bar_close_button_enable = 0;
      group_bar_button_size = 16;
      group_bar_button_margin = 4;
      group_bar_button_color = hex "base08" "ff";
      group_bar_decorate_fg_color = hex "base06" "ff";
      group_bar_decorate_bg_color = hex "base00" "ff";
      group_bar_decorate_focus_fg_color = hex "base06" "ff";
      group_bar_decorate_focus_bg_color = hex "base0B" "ff";
      group_bar_decorate_border_color = hex "base03" "ff";
      group_bar_decorate_border_width = 4;
      group_bar_decorate_corner_radius = 0;
      group_bar_decorate_padding_x = 0;
      group_bar_decorate_padding_y = 0;
      group_bar_decorate_font_desc = "Terminess Nerd Font Bold 11";

      # Auto tab bar
      tab_bar_height = 24;
      tab_bar_decorate_fg_color = hex "base06" "ff";
      tab_bar_decorate_bg_color = hex "base00" "ff";
      tab_bar_decorate_focus_fg_color = hex "base0D" "ff";
      tab_bar_decorate_focus_bg_color = hex "base02" "ff";
      tab_bar_decorate_border_color = hex "base03" "ff";
      tab_bar_decorate_border_width = 4;
      tab_bar_decorate_corner_radius = 0;
      tab_bar_decorate_padding_x = 0;
      tab_bar_decorate_padding_y = 0;
      tab_bar_decorate_font_desc = "Terminess Nerd Font Bold 11";

      # Title message bar
      title_message_bar_height = 52;
      title_message_bar_gap = 20;
      title_message_bar_decorate_fg_color = hex "base06" "ff";
      title_message_bar_decorate_bg_color = hex "base00" "ff";
      title_message_bar_decorate_focus_fg_color = hex "base0B" "ff";
      title_message_bar_decorate_focus_bg_color = hex "base02" "ff";
      title_message_bar_decorate_border_color = hex "base03" "ff";
      title_message_bar_decorate_border_width = 0;
      title_message_bar_decorate_corner_radius = 0;
      title_message_bar_decorate_padding_x = 0;
      title_message_bar_decorate_padding_y = 0;
      title_message_bar_decorate_font_desc = "Terminess Nerd Font Bold 13";

      # Cursor
      cursor_size = 24;
      cursor_theme = "Bibata-Modern-Ice";
    };
  };
}
