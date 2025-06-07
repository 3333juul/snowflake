{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.environment.desktop;

  settings = {
    general = {
      home_row_keys = "";
      modes = "floating,click";
      cancellation_status_code = 0;
    };

    mode_tile = {
      label_color = "#fffd";
      label_select_color = "#fd0d";
      unselectable_bg_color = "#2226";
      selectable_bg_color = "#0304";
      selectable_border_color = "#040c";
      label_font_family = "sans-serif";
      label_font_size = "8 50% 100";
      label_symbols = "abcdefghijklmnopqrstuvwxyz";
    };

    mode_floating = {
      source = "detect";
      label_color = "#fffd";
      label_select_color = "#fd0d";
      unselectable_bg_color = "#2226";
      selectable_bg_color = "#98971ACC";
      selectable_border_color = "#040c";
      label_font_family = "Terminess Nerd Font";
      label_font_size = "17 50% 100";
      label_symbols = "abcdefghijklmnopqrstuvwxyz";
    };

    mode_bisect = {
      label_color = "#fffd";
      label_font_size = 20;
      label_font_family = "sans-serif";
      label_padding = 12;
      pointer_size = 20;
      pointer_color = "#e22d";
      unselectable_bg_color = "#2226";
      even_area_bg_color = "#0304";
      even_area_border_color = "#0408";
      odd_area_bg_color = "#0034";
      odd_area_border_color = "#0048";
      history_border_color = "#3339";
    };

    mode_split = {
      pointer_size = 20;
      pointer_color = "#e22d";
      bg_color = "#2226";
      area_bg_color = "#11111188";
      vertical_color = "#8888ffcc";
      horizontal_color = "#008800cc";
      history_border_color = "#3339";
    };

    mode_click = {
      button = "left";
    };
  };
in {
  config = mkIf (cfg.type == "Hyprland") {
    home.packages = with pkgs; [
      (wl-kbptr.overrideAttrs {
        src = fetchFromGitHub {
          owner = "moverest";
          repo = "wl-kbptr";
          rev = "92cafbf99cc4eb3cd10c8086805d56475c2749bd";
          hash = "sha256-nCvzGWlW6scygwiZtpgCySNz5YIw7/Beuh5Gw31+6TM=";
        };
      })
      wlrctl
    ];

    xdg.configFile."wl-kbptr/config".text = lib.generators.toINI {} settings;
  };
}
