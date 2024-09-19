{
  wayland.windowManager.hyprland.settings = {
    bind = [
      #== Window/Session actions ========================================================================
      "$mainMod, Q, killactive"
      "ALT, F4, exec, killall brave && hyprctl dispatch exit"
      "$mainMod SHIFT, F, exec, togglefloating"
      "$mainMod, M, fullscreen, 1"
      "$mainMod, F, fullscreen"
      "$mainMod ALT CTRL, L, exec, hyprlock"
      "$mainMod CTRL SHIFT, B, exec, ~/.config/waybar/launch.sh"
      "$mainMod SHIFT, M, exec, pypr zoom"
      "$mainMod SHIFT, P, exec, betterpin"
      "$mainMod ALT, P, exec, changelayout"
      "$mainMod SHIFT, I, exec, wininfo"
      "$mainMod ALT, C, exec, python3 floatinggrid.py horizontal"
      "$mainMod ALT, X, exec, python3 floatinggrid.py vertical"
      "$mainMod, semicolon, exec, colorpicker"
      "$mainMod ALT, semicolon, exec, hyprctl seterror disable"

      #== Application shortcuts =========================================================================
      "$mainMod, RETURN, exec, kitty"
      "$mainMod, W, exec, brave"
      "$mainMod, P, exec, pkill tofi || tofi-run | xargs hyprctl dispatch exec"
      "$mainMod, $mainMod_L, exec, pkill tofi || tofi-drun --drun-launch=true"
      #"$mainMod, $mainMod_L, exec, pkill rofi || testscript"
      "$mainMod, R, exec, kitty --class yazi -e yazi"
      "$mainMod, C, exec, kitty --class neovim -e nvim"

      #== Scripts =======================================================================================
      "$mainMod CTRL, slash, exec, ocr"

      #== Rofi scripts ==================================================================================
      "$mainMod CTRL, D, exec, pkill tofi || quicklinks --kitty"
      "$mainMod CTRL, X, exec, pkill tofi || powermenu"
      "$mainMod CTRL, C, exec, pkill tofi || cliphist list | tofi | cliphist decode | wl-copy"
      "$mainMod CTRL, W, exec, pkill tofi || focuswindow tofi"
      "$mainMod CTRL, E, exec, pkill tofi || togglespecial-menu"
      "$mainMod CTRL, Z, exec, pkill tofi || selectwallpaper"

      #== Screenshot/Screencapture ======================================================================
      "$mainMod CTRL, S, exec, screenshot-wl sf"
      ", 82, exec, screenshot-wl m"
      "$mainMod, 82, exec, screenshot-wl p"
      "$mainMod ALT, 82, exec, grimblast copysave output"
      "$mainMod, F10, pass, ^(com.obsproject.Studio)$"

      #== Focus workspace ===============================================================================
      "$mainMod, 1, exec, closespecial -x 1"
      "$mainMod, 2, exec, closespecial -x 2"
      "$mainMod, 3, exec, closespecial -x 3"
      "$mainMod, 4, exec, closespecial -x 4"
      "$mainMod, 5, exec, closespecial -x 5"
      "$mainMod, 6, exec, closespecial -x 6"
      "$mainMod, 7, exec, closespecial -x 7"
      "$mainMod, 8, exec, closespecial -x 8"
      "$mainMod, 9, exec, closespecial -x 9"
      "$mainMod, 0, exec, closespecial -x 10"
      "$mainMod, Tab, exec, prevclosespecial"

      "$mainMod, V, exec, pypr change_workspace -1"
      "$mainMod, N, exec, pypr change_workspace +1"

      "$mainMod CTRL, right, exec, closespecial -x r+1"
      "$mainMod CTRL, left, exec, closespecial -x r-1"
      "$mainMod CTRL, down, exec, closespecial -x empty"

      #== Move active window to a workspace =============================================================
      "$mainMod ALT, 1, movetoworkspace, 1"
      "$mainMod ALT, 2, movetoworkspace, 2"
      "$mainMod ALT, 3, movetoworkspace, 3"
      "$mainMod ALT, 4, movetoworkspace, 4"
      "$mainMod ALT, 5, movetoworkspace, 5"
      "$mainMod ALT, 6, movetoworkspace, 6"
      "$mainMod ALT, 7, movetoworkspace, 7"
      "$mainMod ALT, 8, movetoworkspace, 8"
      "$mainMod ALT, 9, movetoworkspace, 9"
      "$mainMod ALT, 0, movetoworkspace, 10"

      "$mainMod ALT, V, movetoworkspace, r-1"
      "$mainMod ALT, N, movetoworkspace, r+1"

      #== Move window silently to workspace =============================================================
      "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
      "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
      "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
      "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
      "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
      "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
      "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
      "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
      "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
      "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
      "$mainMod SHIFT, V, movetoworkspacesilent, r-1"
      "$mainMod SHIFT, N, movetoworkspacesilent, r+1"

      #== Toggle window =================================================================================
      "$mainMod CTRL, 2, exec, togglewindow -c Brave-browser"
      "$mainMod CTRL, 3, exec, togglewindow -c neovim"
      "$mainMod CTRL, 4, exec, togglewindow -c yazi"
      "$mainMod CTRL, 5, exec, togglewindow -c obsidian"
      "$mainMod CTRL, 6, exec, togglewindow -c Zotero"
      "$mainMod CTRL, 7, exec, togglewindow -c vesktop"
      "$mainMod SHIFT, W, exec, togglewindow -c Brave-browser"
      "$mainMod SHIFT, O, exec, togglewindow -c obsidian"
      "$mainMod SHIFT, E, exec, togglewindow -b"
      "$mainMod, E, exec, pkill tofi || togglewindow -r 'tofi --height 400 --prompt-text=Window: '"

      "$mainMod SHIFT, U, exec, toggleurgent -t"
      "$mainMod, U, focusurgentorlast"

      #== Monitor =======================================================================================
      "$mainMod, comma, focusmonitor, +1"
      "$mainMod, period, focusmonitor, -1"
      "$mainMod SHIFT, comma, movewindow,mon:+1"
      "$mainMod SHIFT, period, movewindow,mon:-1"
      "$mainMod, SPACE, exec, pypr shift_monitors +1"

      #== Special workspaces ============================================================================
      "$mainMod, backslash, togglespecialworkspace, scratchpad"
      "$mainMod SHIFT, backslash, exec, movetospecial --silent in out special:scratchpad"
      "$mainMod CTRL, backslash, exec, movetospecial --silent in out --launcher"

      "$mainMod, grave, togglespecialworkspace, obsidian"
      "$mainMod, S, togglespecialworkspace, music"
      "$mainMod SHIFT, R, togglespecialworkspace, rss"
      "$mainMod, T, togglespecialworkspace, tasks"
      "$mainMod SHIFT, A, togglespecialworkspace, anki"
      "$mainMod, bracketright, togglespecialworkspace, ai"
      "$mainMod ALT, F, togglespecialworkspace, dict"
      "$mainMod ALT, D, togglespecialworkspace, type"
      "$mainMod CTRL, P, togglespecialworkspace, mail"
      "$mainMod, Y, togglespecialworkspace, sound"

      #== Dynamic windows ===============================================================================
      "$mainMod, B, exec, dynamicwindow -v special:dynamic"
      "$mainMod SHIFT, B, exec, dynamicwindow -t special:dynamic"

      #== Groups ========================================================================================
      "$mainMod, G, exec, hyprtabs"
      "$mainMod SHIFT, G, togglegroup"
      "$mainMod CTRL, J, changegroupactive, f"
      "$mainMod CTRL, K, changegroupactive, b"
      "$mainMod CTRL SHIFT, J, movegroupwindow, f"
      "$mainMod CTRL SHIFT, K, movegroupwindow, b"

      #== Master Layout =================================================================================
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

      #== Plugins =======================================================================================
      "$mainMod, Z, exec, easymotion"
    ];

    bindl = [
      ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
      "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
    ];

    binde = [
      ",XF86AudioMute,exec, changevolume mute"
      ",XF86AudioRaiseVolume,exec, changevolume up"
      ",XF86AudioLowerVolume,exec, changevolume down"
      #== Master Layout =================================================================================
      "$mainMod SHIFT, H, resizeactive, 0 80"
      "$mainMod, H, resizeactive, -100 0"
      "$mainMod SHIFT, L, resizeactive, 0 -80"
      "$mainMod, L, resizeactive, 100 0"
    ];

    bindm = [
      #== Mouse =========================================================================================
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
