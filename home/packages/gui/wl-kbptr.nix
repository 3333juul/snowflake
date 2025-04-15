{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (inputs.self.packages.${pkgs.system}) wl-kbptr;

  cfg = osConfig.garden.environment.desktop;

  settings = {
    general = {
      home_row_keys = "";
      modes = "tile,bisect,floating";
    };

    mode_tile = {
      label_color = "#fffd";
      label_select_color = "#fd0d";
      unselectable_bg_color = "#2226";
      selectable_bg_color = "#0304";
      selectable_border_color = "#040c";
      label_font_family = "sans-serif";
      label_symbols = "abcdefghijklmnopqrstuvwxyz";
    };

    mode_floating = {
      source = "stdin";
      label_color = "#fffd";
      label_select_color = "#fd0d";
      unselectable_bg_color = "#2226";
      selectable_bg_color = "#1718";
      selectable_border_color = "#040c";
      label_font_family = "sans-serif";
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

    mode_click = {
      button = "left";
    };
  };
in {
  config = mkIf (cfg.type == "Hyprland") {
    home.packages = with pkgs; [
      wl-kbptr
      wlrctl
    ];

    # xdg.configFile."wl-kbptr/config".text = lib.generators.toINI {} settings;
  };
}
