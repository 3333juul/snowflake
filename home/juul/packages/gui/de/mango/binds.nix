{osConfig, ...}: let
  inherit
    (osConfig.garden.programs.defaults)
    terminal
    editor
    browser
    fileManager
    screenLocker
    launcher
    ;
in {
  wayland.windowManager.mango = {
    settings = {
      # Reload / quit
      bind = [
        "SUPER+CTRL,r,reload_config"
        "SUPER+SHIFT,q,quit"
        "SUPER,q,killclient,"

        # Spawn programs
        "SUPER,Return,spawn,${terminal}"
        "SUPER,w,spawn,${browser}"
        "SUPER,c,spawn,kitty --class ${editor} -e ${editor}"
        "SUPER,r,spawn,kitty --class ${fileManager} -e ${fileManager}"
        "SUPER+ALT+CTRL,l,spawn,${screenLocker}"
        "SUPER,space,spawn,${{
            tofi = ''sh -c "pkill tofi || tofi-drun --drun-launch=true"'';
            vicinae = "vicinae toggle";
          }.${
            launcher
          }}"

        # Switch window focus
        "SUPER,J,focusstack,next"
        "SUPER,K,focusstack,prev"
        "SUPER,Left,focusdir,left"
        "SUPER,Right,focusdir,right"
        "SUPER,Up,focusdir,up"
        "SUPER,Down,focusdir,down"

        # Swap window
        "SUPER+SHIFT,j,exchange_stack_client,next"
        "SUPER+SHIFT,k,exchange_stack_client,prev"
        "SUPER+SHIFT,Up,exchange_client,up"
        "SUPER+SHIFT,Down,exchange_client,down"
        "SUPER+SHIFT,Left,exchange_client,left"
        "SUPER+SHIFT,Right,exchange_client,right"

        # Switch window status
        "SUPER,g,toggleglobal,"
        "ALT,Tab,toggleoverview,"
        "ALT,backslash,togglefloating,"
        "ALT,a,togglemaximizescreen,"
        "ALT,f,togglefullscreen,"
        "ALT+SHIFT,f,togglefakefullscreen,"
        "SUPER,i,minimized,"
        "SUPER,o,toggleoverlay,"
        "SUPER+SHIFT,I,restore_minimized"
        "ALT,z,toggle_scratchpad"

        # Scroller layout
        "ALT,e,set_proportion,1.0"
        "ALT,x,switch_proportion_preset,"

        # Switch layout
        "SUPER,n,switch_layout"
        "SUPER,m,spawn,monocle-test"

        # Tag switch
        "SUPER,Left,viewtoleft,0"
        "CTRL,Left,viewtoleft_have_client,0"
        "SUPER,Right,viewtoright,0"
        "CTRL,Right,viewtoright_have_client,0"
        "CTRL+SUPER,Left,tagtoleft,0"
        "CTRL+SUPER,Right,tagtoright,0"

        # Prev tagset
        "SUPER,Tab,view,-1,0"

        # View tags
        "SUPER,1,view,1,0"
        "SUPER,2,view,2,0"
        "SUPER,3,view,3,0"
        "SUPER,4,view,4,0"
        "SUPER,5,view,5,0"
        "SUPER,6,view,6,0"
        "SUPER,7,view,7,0"
        "SUPER,8,view,8,0"
        "SUPER,9,view,9,0"

        # Toggle view tags
        "SUPER+CTRL,1,toggleview,1,0"
        "SUPER+CTRL,2,toggleview,2,0"
        "SUPER+CTRL,3,toggleview,3,0"
        "SUPER+CTRL,4,toggleview,4,0"
        "SUPER+CTRL,5,toggleview,5,0"
        "SUPER+CTRL,6,toggleview,6,0"
        "SUPER+CTRL,7,toggleview,7,0"
        "SUPER+CTRL,8,toggleview,8,0"
        "SUPER+CTRL,9,toggleview,9,0"

        # Move client to tag and focus it
        "SUPER+SHIFT,1,tag,1,0"
        "SUPER+SHIFT,2,tag,2,0"
        "SUPER+SHIFT,3,tag,3,0"
        "SUPER+SHIFT,4,tag,5,0"
        "SUPER+SHIFT,6,tag,6,0"
        "SUPER+SHIFT,7,tag,7,0"
        "SUPER+SHIFT,8,tag,8,0"
        "SUPER+SHIFT,9,tag,9,0"

        # Monitor switch
        "alt+shift,Left,focusmon,left"
        "alt+shift,Right,focusmon,right"
        "SUPER+Alt,Left,tagmon,left"
        "SUPER+Alt,Right,tagmon,right"

        # Gaps
        "ALT+SHIFT,X,incgaps,1"
        "ALT+SHIFT,Z,incgaps,-1"
        "ALT+SHIFT,R,togglegaps"

        # Move window
        "CTRL+SHIFT,Up,movewin,+0,-50"
        "CTRL+SHIFT,Down,movewin,+0,+50"
        "CTRL+SHIFT,Left,movewin,-50,+0"
        "CTRL+SHIFT,Right,movewin,+50,+0"

        # Resize window
        "CTRL+ALT,Up,resizewin,+0,-50"
        "CTRL+ALT,Down,resizewin,+0,+50"
        "SUPER,h,resizewin,-50,+0"
        "SUPER,l,resizewin,+50,+0"

        # Scratchpad
        "SUPER,s,toggle_named_scratchpad,spotify,none,spotify"
      ];

      # Mouse button bindings
      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
        "NONE,btn_left,toggleoverview,1"
        "NONE,btn_right,killclient,0"
      ];

      # Axis bindings
      axisbind = [
        "SUPER,UP,viewtoleft_have_client"
        "SUPER,DOWN,viewtoright_have_client"
      ];
    };
  };
}
