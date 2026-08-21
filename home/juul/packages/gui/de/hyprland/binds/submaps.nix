{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  inherit (lib.strings) optionalString;

  cfg = osConfig.garden.environment.desktop.hyprland.plugins;
in {
  wayland.windowManager.hyprland = {
    extraConfig =
      ''
        # hyprlang noerror true
      ''
      + optionalString (pkgs ? wl-kbptr)
      ''
        # Cursor submap (similar to the Mouse mode in Sway)
        submap=cursor

        # Jump cursor to a position
        # bind=,a,exec,hyprctl dispatch submap reset && wl-kbptr && hyprctl dispatch submap cursor
        bind=,a,exec,hyprctl dispatch submap reset && wl-kbptr -o modes=floating,click -o mode_floating.source=detect && hyprctl dispatch submap cursor

        # Cursor movement
        binde=,j,exec,wlrctl pointer move 0 10
        binde=,k,exec,wlrctl pointer move 0 -10
        binde=,l,exec,wlrctl pointer move 10 0
        binde=,h,exec,wlrctl pointer move -10 0

        # Left button
        bind=,s,exec,wlrctl pointer click left
        # Middle button
        bind=,d,exec,wlrctl pointer click middle
        # Right button
        bind=,f,exec,wlrctl pointer click right

        # Scroll up and down
        binde=,e,exec,wlrctl pointer scroll 10 0
        binde=,r,exec,wlrctl pointer scroll -10 0

        # Scroll left and right
        binde=,t,exec,wlrctl pointer scroll 0 -10
        binde=,g,exec,wlrctl pointer scroll 0 10

        # Exit cursor submap
        bind=,escape,exec, hyprctl dispatch submap reset

        submap = reset

        # Entrypoint
        bind=$mainMod,o,exec,hyprctl dispatch submap cursor
      ''
      + optionalString (cfg.hyprland-easymotion.enable && cfg.hycov.enable) ''
        # hycov-easymotion submap
        submap = __easymotionsubmap__

        bind = ALT, right, hycov:movefocus, rightcross
        bind = ALT, left, hycov:movefocus, leftcross
        bind = ALT, up, hycov:movefocus, upcross
        bind = ALT, down, hycov:movefocus, downcross

        bind = ALT, H, hycov:movefocus, leftcross
        bind = ALT, J, hycov:movefocus, downcross
        bind = ALT, K, hycov:movefocus, upcross
        bind = ALT, L, hycov:movefocus, rightcross

        bind = ,Tab, event, changemode

        bind = ALT, Tab, hycov:leaveoverview

        bind = ALT, Q, killactive

        submap = reset
      '';
  };
}
