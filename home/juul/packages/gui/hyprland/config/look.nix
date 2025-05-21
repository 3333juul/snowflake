{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 7;
      gaps_out = 14;
      border_size = 2;
      "col.active_border" = "rgb(ebdbb2)";
      "col.inactive_border" = "rgb(1d2021)";
    };

    decoration = {
      rounding = 0;
      dim_special = 0.7;

      blur = {
        enabled = true;
        size = 10;
        passes = 6;
        noise = 0.3;
      };

      shadow = {
        enabled = true;
        ignore_window = true;
        offset = "6 6";
        render_power = 4;
        range = 30;
        #color = "rgba(00000055)";
      };
    };

    group = {
      #col.border_active = rgb(6e5050)
      #col.border_inactive = rgb(473939)
      #col.border_locked_active =
      #col.border_locked_inactive=

      groupbar = {
        font_family = "Terminess Nerd Font";
        font_size = 12;
        gradients = true;
        height = 13;
        "col.active" = "rgba(98971AE6)";
        "col.inactive" = "rgba(282828E6)";
        #"col.locked_active" = "rgba()";
        #"col.locked_inactive" = "rgba()";
        text_color = "rgb(ebdbb2)";
      };
    };
  };
}
