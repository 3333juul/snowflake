{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hycov.packages.${pkgs.system}.hycov
      inputs.hyprland-easymotion.packages.${pkgs.system}.hyprland-easymotion
    ];
    settings.plugin = {
      easymotion = {
        textsize = 30;
        textcolor = "rgb(ebdbb2)";
        bgcolor = "rgba(40,40,40,1)";
        textfont = "Terminus";
        textpadding = "7,15,7,15";
        bordersize = 1;
        bordercolor = "rgb(ebdbb2)";
        rounding = 0;
        #motionkeys=abcdefghijklmnopqrstuvwxyz1234567890
        #motionkeys=fjghdkslaemuvitywoqpcbnxz1234567890
        #motionkeys=jkluiopyhnmfdsatgvcewqzx1234567890 # bez b i r
        motionkeys = "jkhluiopynmbfdsatgrvcewqzx1234567890";
      };
      hycov = {
        overview_gappo = 60;
        overview_gappi = 24;
        enable_hotarea = 0;
        hotarea_monitor = "all";
        hotarea_pos = 1;
        hotarea_size = 10;
        swipe_fingers = 4;
        move_focus_distance = 100;
        enable_gesture = 0;
        auto_exit = 1;
        auto_fullscreen = 0;
        only_active_workspace = 0;
        only_active_monitor = 0;
        enable_alt_release_exit = 0;
        alt_replace_key = "Alt_L";
        alt_toggle_auto_next = 0;
        click_in_cursor = 1;
        hight_of_titlebar = 0;
        show_special = 0;
      };
    };
  };
}
