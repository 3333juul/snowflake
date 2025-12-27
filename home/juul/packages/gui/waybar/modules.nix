{
  "hyprland/workspaces" = {
    format = "{name}";
    on-click-release = "activate";
    sort-by-numbers = false;
    on-scroll-up = "hyprctl dispatch focusworkspaceoncurrentmonitor e+1";
    on-scroll-down = "hyprctl dispatch focusworkspaceoncurrentmonitor e-1";
    move-to-monitor = true;
    persistent-workspaces = {
      "1" = "I";
      "2" = "II";
      "3" = "III";
      "4" = "IV";
      "5" = "V";
      "6" = "VI";
      "7" = "VII";
      "8" = "VIII";
      "9" = "IX";
      "10" = "X";
    };
  };

  "hyprland/language" = {
    format = "{short}";
    keyboard-name = "at-translated-set-2-keyboard";
  };

  "hyprland/mode" = {
    format = "<span style=\"italic\">{}</span>";
  };

  "hyprland/scratchpad" = {
    format = "{icon} {count}";
    show-empty = false;
    format-icons = [
      ""
      ""
    ];
    tooltip = true;
    tooltip-format = "{app}: {title}";
  };

  "hyprland/window" = {
    format = " {title}";
    separate-outputs = true;
  };

  idle_inhibitor = {
    format = "{icon}";
    format-icons = {
      activated = "";
      deactivated = "";
    };
  };

  tray = {
    icon-size = 15;
    spacing = 5;
  };

  clock = {
    interval = 1;
    format = "󰥔  {:%H:%M:%S}";
    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
  };

  cpu = {
    format = "  {usage}%";
    tooltip = false;
  };

  memory = {
    format = "  {}%";
  };

  backlight = {
    format = "{percent}% {icon}";
    format-icons = [
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
      ""
    ];
  };

  battery = {
    states = {
      warning = 30;
      critical = 15;
    };
    format = "{capacity}% {icon}";
    format-charging = "{capacity}% 󰂄";
    format-plugged = "{capacity}% ";
    format-alt = "{time} {icon}";
    format-icons = [
      "󰁺"
      "󰁻"
      "󰁼"
      "󰁽"
      "󰁾"
      "󰁿"
      "󰂀"
      "󰂁"
      "󰂂"
      "󰁹"
    ];
  };

  network = {
    format-wifi = " ";
    format-ethernet = "{ipaddr}/{cidr} ";
    tooltip-format = "{ifname} via {gwaddr} ";
    format-linked = "{ifname} (No IP) ";
    format-disconnected = "Disconnected ⚠";
    format-alt = "{ifname}: {ipaddr}/{cidr}";
  };

  pulseaudio = {
    format = "{icon}  {volume}%";
    format-muted = "";
    format-icons = {
      default = [
        ""
        ""
      ];
    };
    scroll-step = 1;
    on-click = "hyprctl dispatch togglespecialworkspace sound";
    ignored-sinks = [
      "Easy Effects Sink"
    ];
  };

  mpris = {
    format = "{player_icon} {artist} - {title}";
    format-paused = "{player_icon} {artist} - {title}";
    on-click = "playerctl -p spotify play-pause";
    on-click-right = "playerctl -p spotify next";
    on-click-middle = "hyprctl dispatch togglespecialworkspace music";
    player = "spotify";
    player-icons = {
      chromium = "";
      default = "";
      firefox = "";
      kdeconnect = "";
      mopidy = "";
      mpv = "󰐹";
      spotify = "<span foreground='#98971a'></span>";
      vlc = "󰕼";
    };
    max-length = 45;
  };

  # "custom/weather" = {
  #   format = "{}";
  #   tooltip = true;
  #   interval = 3600;
  #   exec = "weather.py";
  #   return-type = "json";
  # };

  "custom/todoist" = {
    format = "{icon} {text}";
    tooltip = true;
    on-click = "hyprctl dispatch togglespecialworkspace tasks";
    interval = 60;
    format-icons = {
      default = "";
    };
    exec = "todoist-waybar";
    return-type = "json";
  };

  temperature = {
    format = " {temperatureC}°C";
  };

  "custom/windowstate_1" = {
    exec = "cat /tmp/windowstate_1";
    signal = 8;
  };

  "custom/windowstate_0" = {
    exec = "cat /tmp/windowstate_0";
    signal = 8;
  };

  "custom/colorpicker" = {
    format = "{icon} {text}";
    on-click = "colorpicker";
    on-click-right = "colorpicker -h";
    format-icons = {
      default = "";
    };
  };

  "custom/notification" = {
    tooltip = false;
    format = "{icon}";
    format-icons = {
      notification = "<span foreground='red'><sup></sup></span>";
      none = "";
      dnd-notification = "<span foreground='red'><sup></sup></span>";
      dnd-none = "";
      inhibited-notification = "<span foreground='red'><sup></sup></span>";
      inhibited-none = "";
      dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
      dnd-inhibited-none = "";
    };
    return-type = "json";
    exec-if = "which swaync-client";
    exec = "swaync-client -swb";
    on-click = "swaync-client -t -sw";
    on-click-right = "swaync-client -d -sw";
    escape = true;
  };

  "custom/lyrics" = {
    return-type = "json";
    format = "{icon}  {0}";
    hide-empty-text = true;

    format-icons = {
      playing = "";
      paused = "";
      lyric = "";
      music = "󰝚";
      no_lyric = "󰝚";
      # getting = "";
    };

    exec-if = "which waybar-lyric";
    exec = "waybar-lyric --quiet";
    on-click = "waybar-lyric play-pause";
  };
}
