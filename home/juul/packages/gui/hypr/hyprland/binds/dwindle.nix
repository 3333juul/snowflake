{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.environment.desktop.hyprland) layout;
in {
  wayland.windowManager.hyprland.settings = mkIf (layout == "dwindle") {
    bind = [
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"

      "$mainMod SHIFT, K, swapwindow, u"
      "$mainMod SHIFT, J, swapwindow, d"
      "$mainMod SHIFT, H, swapwindow, l"
      "$mainMod SHIFT, L, swapwindow, r"

      "$mainMod ALT, K, movewindow, u"
      "$mainMod ALT, J, movewindow, d"
      "$mainMod ALT, H, movewindow, l"
      "$mainMod ALT, L, movewindow, r"
    ];

    binde = [
      "$mainMod CTRL, K, resizeactive, 0 -80"
      "$mainMod CTRL, J, resizeactive, 0 80"
      "$mainMod CTRL, H, resizeactive, -100 0"
      "$mainMod CTRL, L, resizeactive, 100 0"
    ];
  };
}
