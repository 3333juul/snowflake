{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (osConfig.garden.programs.defaults) terminal editor browser fileManager screenLocker launcher;
  inherit (builtins) concatLists genList;

  cfg = osConfig.garden.environment.desktop.hyprland.plugins;
in {
  imports = [
    ./dwindle.nix
    ./master.nix
    ./submaps.nix
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind =
        [
          #== Window/Session actions ========================================================================
          "$mainMod, Q, killactive"
          "ALT, F4, exec, killall brave && hyprctl dispatch exit"
          "$mainMod SHIFT, F, exec, togglefloating"
          "$mainMod, M, fullscreen, 1"
          "$mainMod CTRL, F, fullscreen"
          "$mainMod, F, exec, wl-kbptr -o modes=floating,click -o mode_floating.source=detect"
          "$mainMod SHIFT, M, exec, pypr zoom"
          "$mainMod SHIFT, P, exec, betterpin"
          "$mainMod ALT, P, exec, changelayout"
          "$mainMod SHIFT, I, exec, wininfo"
          "$mainMod ALT, C, exec, floatinggrid horizontal"
          "$mainMod ALT, X, exec, floatinggrid vertical"
          "$mainMod, semicolon, exec, colorpicker"
          "$mainMod ALT, semicolon, exec, hyprctl seterror disable"

          #== Application shortcuts =========================================================================
          "$mainMod, RETURN, exec, ${terminal}"
          "$mainMod, W, exec, ${browser}"
          "$mainMod, C, exec, kitty --class ${editor} -e ${editor}"
          "$mainMod, R, exec, kitty --class ${fileManager} -e ${fileManager}"
          "$mainMod ALT CTRL, L, exec, ${screenLocker}"
          "$mainMod, P, exec, pkill tofi || tofi-run | xargs hyprctl dispatch exec"

          "$mainMod, $mainMod_L, exec, ${{
              tofi = "pkill tofi || tofi-drun --drun-launch=true";
              vicinae = "vicinae toggle";
            }.${
              launcher
            }}"

          #== Scripts =======================================================================================
          "$mainMod CTRL, slash, exec, ocr"
          "$mainMod SHIFT, slash, exec, ocr-lookup"

          #== Launcher scripts ==============================================================================
          "$mainMod CTRL, D, exec, pkill tofi || quicklinks --kitty"
          "$mainMod CTRL, X, exec, pkill tofi || powermenu"
          "$mainMod CTRL, C, exec, pkill tofi || cliphist list | tofi | cliphist decode | wl-copy"
          "$mainMod CTRL, W, exec, pkill tofi || focuswindow tofi"
          "$mainMod CTRL, E, exec, pkill tofi || togglespecial-menu"
          "$mainMod CTRL, Z, exec, pkill rofi || selectwallpaper --preview"
          "$mainMod CTRL, R, exec, pkill rofi || cd ~/media/memes && rofi-gridview"

          #== Screenshot/Screencapture ======================================================================
          "$mainMod CTRL, S, exec, screenshot sf"
          ", Print, exec, screenshot m"
          "$mainMod, Print, exec, screenshot p"

          #== Toggle window =================================================================================
          "$mainMod CTRL, 2, exec, togglewindow -c brave-browser"
          "$mainMod CTRL, 3, exec, togglewindow -c neovim"
          "$mainMod CTRL, 4, exec, togglewindow -c yazi"
          "$mainMod CTRL, 5, exec, togglewindow -c obsidian"
          "$mainMod CTRL, 6, exec, togglewindow -c Zotero"
          "$mainMod CTRL, 7, exec, togglewindow -c vesktop"
          "$mainMod SHIFT, W, exec, togglewindow -c brave-browser"
          "$mainMod SHIFT, O, exec, togglewindow -c obsidian"
          "$mainMod SHIFT, E, exec, togglewindow -b"
          "$mainMod, E, exec, pkill tofi || togglewindow -r 'tofi --height 400 --prompt-text=Window: '"

          #== Urgent windows ================================================================================
          "$mainMod, U, focusurgentorlast"
          "$mainMod SHIFT, U, exec, toggleurgent -t"

          #== Monitors ======================================================================================
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
          "$mainMod CTRL, A, togglespecialworkspace, nix"

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

          #== Focus with arrow keys =========================================================================
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
        ]
        #== Workspace behavior ==============================================================================
        ++ (concatLists (genList (i: let
            ws = i + 1;
          in [
            "$mainMod, code:1${toString i}, focusworkspaceoncurrentmonitor, ${toString ws}"
            "$mainMod ALT, code:1${toString i}, movetoworkspace, ${toString ws}"
            "$mainMod SHIFT, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
          ])
          10))
        ++ [
          "$mainMod CTRL, right, exec, focusworkspaceoncurrentmonitor, r+1"
          "$mainMod CTRL, left, exec, focusworkspaceoncurrentmonitor, r-1"
          "$mainMod CTRL, down, exec, focusworkspaceoncurrentmonitor, empty"
          "$mainMod, V, exec, pypr change_workspace -1"
          "$mainMod, N, exec, pypr change_workspace +1"
          "$mainMod ALT, V, movetoworkspace, r-1"
          "$mainMod ALT, N, movetoworkspace, r+1"
          "$mainMod SHIFT, V, movetoworkspacesilent, r-1"
          "$mainMod SHIFT, N, movetoworkspacesilent, r+1"
          "$mainMod, Tab, exec, prevclosespecial"
        ]
        #== Plugins =========================================================================================
        ++ optionals cfg.hycov.enable [
          "ALT, Tab, hycov:toggleoverview"
        ]
        ++ optionals cfg.hyprland-easymotion.enable [
          "$mainMod, Z, exec, easymotion"
        ];

      bindl = [
        #== Brightness ======================================================================================
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
        "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"
      ];

      binde = [
        #== Volume ==========================================================================================
        ",XF86AudioMute,exec, changevolume mute"
        ",XF86AudioRaiseVolume,exec, changevolume up"
        ",XF86AudioLowerVolume,exec, changevolume down"
      ];

      bindm = [
        #== Mouse ===========================================================================================
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
