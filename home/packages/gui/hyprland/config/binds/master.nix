{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.environment.desktop.hyprland) layout;
in {
  wayland.windowManager.hyprland.settings = mkIf (layout == "master") {
    bind = [
      "$mainMod, J, layoutmsg, cyclenext"
      "$mainMod, K, layoutmsg, cycleprev"
      "$mainMod SHIFT, J, layoutmsg, swapnext"
      "$mainMod SHIFT, K, layoutmsg, swapprev"

      "$mainMod, I, layoutmsg, addmaster"
      "$mainMod, D, layoutmsg, removemaster"

      "$mainMod CTRL, RETURN, layoutmsg, focusmaster"
      "$mainMod SHIFT, RETURN, layoutmsg, swapwithmaster"

      "$mainMod ALT, M, layoutmsg, orientationcycle center left"
      "$mainMod ALT, up, layoutmsg, orientationtop"
      "$mainMod ALT, down, layoutmsg, orientationbottom"
      "$mainMod ALT, left, layoutmsg, orientationleft"
      "$mainMod ALT, right, layoutmsg, orientationright"
    ];

    binde = [
      "$mainMod SHIFT, H, resizeactive, 0 80"
      "$mainMod, H, resizeactive, -100 0"
      "$mainMod SHIFT, L, resizeactive, 0 -80"
      "$mainMod, L, resizeactive, 100 0"
    ];
  };
}
