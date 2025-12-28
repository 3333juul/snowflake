{osConfig, ...}: let
  inherit (osConfig.garden.programs.defaults) terminal editor browser fileManager screenLocker launcher;
in {
  wayland.windowManager.mango = {
    settings = ''
      bind=SUPER+CTRL,r,reload_config
      bind=SUPER+SHIFT,q,quit
      bind=SUPER,q,killclient,

      # spawn programs
      bind=SUPER,Return,spawn,${terminal}
      bind=SUPER,w,spawn,${browser}
      bind=SUPER,c,spawn,kitty --class ${editor} -e ${editor}
      bind=SUPER,r,spawn,kitty --class ${fileManager} -e ${fileManager}
      bind=SUPER+ALT+CTRL,l,spawn,${screenLocker}
      bind=SUPER,space,spawn,${{
          tofi = "pkill tofi || tofi-drun --drun-launch=true";
          vicinae = "vicinae toggle";
        }.${
          launcher
        }}

      # switch window focus
      bind=SUPER,J,focusstack,next
      bind=SUPER,K,focusstack,prev
      bind=SUPER,Left,focusdir,left
      bind=SUPER,Right,focusdir,right
      bind=SUPER,Up,focusdir,up
      bind=SUPER,Down,focusdir,down

      # swap window
      bind=SUPER+SHIFT,j,exchange_stack_client,next
      bind=SUPER+SHIFT,k,exchange_stack_client,prev

      bind=SUPER+SHIFT,Up,exchange_client,up
      bind=SUPER+SHIFT,Down,exchange_client,down
      bind=SUPER+SHIFT,Left,exchange_client,left
      bind=SUPER+SHIFT,Right,exchange_client,right

      # switch window status
      bind=SUPER,g,toggleglobal,
      bind=ALT,Tab,toggleoverview,
      bind=ALT,backslash,togglefloating,
      bind=ALT,a,togglemaximizescreen,
      bind=ALT,f,togglefullscreen,
      bind=ALT+SHIFT,f,togglefakefullscreen,
      bind=SUPER,i,minimized,
      bind=SUPER,o,toggleoverlay,
      bind=SUPER+SHIFT,I,restore_minimized
      bind=ALT,z,toggle_scratchpad

      # scroller layout
      bind=ALT,e,set_proportion,1.0
      bind=ALT,x,switch_proportion_preset,

      # switch layout
      bind=SUPER,n,switch_layout
      bind=SUPER,m,spawn,monocle-test

      # tag switch
      bind=SUPER,Left,viewtoleft,0
      bind=CTRL,Left,viewtoleft_have_client,0
      bind=SUPER,Right,viewtoright,0
      bind=CTRL,Right,viewtoright_have_client,0
      bind=CTRL+SUPER,Left,tagtoleft,0
      bind=CTRL+SUPER,Right,tagtoright,0

      # prev tagset
      bind=SUPER,Tab,view,-1,0

      # view tags
      bind=SUPER,1,view,1,0
      bind=SUPER,2,view,2,0
      bind=SUPER,3,view,3,0
      bind=SUPER,4,view,4,0
      bind=SUPER,5,view,5,0
      bind=SUPER,6,view,6,0
      bind=SUPER,7,view,7,0
      bind=SUPER,8,view,8,0
      bind=SUPER,9,view,9,0

      bind=SUPER+CTRL,1,toggleview,1,0
      bind=SUPER+CTRL,2,toggleview,2,0
      bind=SUPER+CTRL,3,toggleview,3,0
      bind=SUPER+CTRL,4,toggleview,4,0
      bind=SUPER+CTRL,5,toggleview,5,0
      bind=SUPER+CTRL,6,toggleview,6,0
      bind=SUPER+CTRL,7,toggleview,7,0
      bind=SUPER+CTRL,8,toggleview,8,0
      bind=SUPER+CTRL,9,toggleview,9,0


      # tag: move client to the tag and focus it
      # tagsilent: move client to the tag and not focus it
      # bind=Alt,1,tagsilent,1
      bind=SUPER+SHIFT,1,tag,1,0
      bind=SUPER+SHIFT,2,tag,2,0
      bind=SUPER+SHIFT,3,tag,3,0
      bind=SUPER+SHIFT,4,tag,5,0
      bind=SUPER+SHIFT,6,tag,6,0
      bind=SUPER+SHIFT,7,tag,7,0
      bind=SUPER+SHIFT,8,tag,8,0
      bind=SUPER+SHIFT,9,tag,9,0

      # monitor switch
      bind=alt+shift,Left,focusmon,left
      bind=alt+shift,Right,focusmon,right
      bind=SUPER+Alt,Left,tagmon,left
      bind=SUPER+Alt,Right,tagmon,right

      # gaps
      bind=ALT+SHIFT,X,incgaps,1
      bind=ALT+SHIFT,Z,incgaps,-1
      bind=ALT+SHIFT,R,togglegaps

      # movewin
      bind=CTRL+SHIFT,Up,movewin,+0,-50
      bind=CTRL+SHIFT,Down,movewin,+0,+50
      bind=CTRL+SHIFT,Left,movewin,-50,+0
      bind=CTRL+SHIFT,Right,movewin,+50,+0

      # resizewin
      bind=CTRL+ALT,Up,resizewin,+0,-50
      bind=CTRL+ALT,Down,resizewin,+0,+50
      bind=SUPER,h,resizewin,-50,+0
      bind=SUPER,l,resizewin,+50,+0

      # Mouse Button Bindings
      # NONE mode key only work in ov mode
      mousebind=SUPER,btn_left,moveresize,curmove
      #mousebind=NONE,btn_middle,togglemaximizescreen,0
      mousebind=SUPER,btn_right,moveresize,curresize
      mousebind=NONE,btn_left,toggleoverview,1
      mousebind=NONE,btn_right,killclient,0

      # Axis Bindings
      axisbind=SUPER,UP,viewtoleft_have_client
      axisbind=SUPER,DOWN,viewtoright_have_client

      # scratchpad
      bind=SUPER,s,toggle_named_scratchpad,spotify,none,spotify
    '';
  };
}
