{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs;
in {
  programs.waybar.style = mkIf cfg.waybar.enable ''
    * {
      font-family: Terminus;
      font-size: 13px;
      border: 4px;
      min-height: 0;
    }

    /* ─────────────────────────────────────────────────────────────
     * Waybar
     * ───────────────────────────────────────────────────────────── */

    window#waybar {
      background: rgba(40, 40, 40, 0.9);
      color: #ebdbb2;
      border: 1px solid #a89984;
      padding: 0;
      margin: 0;
    }

    window#waybar.hidden {
      opacity: 0.2;
    }

    window#waybar.empty #window {
      background: none;
      margin: 0;
      padding: 0;
    }

    /* ─────────────────────────────────────────────────────────────
     * General
     * ───────────────────────────────────────────────────────────── */

    button {
      border: none;
      border-radius: 0;
      box-shadow: none;
    }

    button:hover {
      background: inherit;
      box-shadow: none;
    }

    tooltip {
      background: #282828;
      color: #ebdbb2;
      border: 1px solid #ebdbb2;
      border-radius: 0;
    }

    /* ─────────────────────────────────────────────────────────────
     * Workspaces
     * ───────────────────────────────────────────────────────────── */

    #workspaces {
      background: transparent;
      padding: 0;
      margin: 0;
    }

    #workspaces button {
      background: transparent;
      color: #ebdbb2;
      padding: 0 5px;
      margin: 0;
      min-width: 0;
    }

    #workspaces button.hidden {
      color: #9e906f;
    }

    #workspaces button:hover {
      color: #d79921;
    }

    #workspaces button.active {
      background: #ddca9e;
      color: #282828;
    }

    #workspaces button.urgent {
      background: #ef5e5e;
      color: #282828;
    }

    #workspaces button.overview {
      background: #ca9297;
      color: #282828;
    }

    .modules-left > widget:first-child > #workspaces {
      margin-left: 1px;
    }

    .modules-right > widget:last-child > #workspaces {
      margin-right: 1px;
    }

    /* ─────────────────────────────────────────────────────────────
     * Window
     * ───────────────────────────────────────────────────────────── */

    #window {
      background: #ca9297;
      color: #282828;
      margin: 0 2px;
      padding-right: 230px;
    }

    /* ─────────────────────────────────────────────────────────────
     * Common modules
     * ───────────────────────────────────────────────────────────── */

    #clock,
    #battery,
    #cpu,
    #memory,
    #backlight,
    #network,
    #pulseaudio,
    #mpris,
    #temperature,
    #idle_inhibitor,
    #custom-weather,
    #custom-todoist,
    #custom-colorpicker,
    #custom-notification {
      color: #ebdbb2;
      background: transparent;
      padding: 0 6px;
    }

    /* ─────────────────────────────────────────────────────────────
     * Battery
     * ───────────────────────────────────────────────────────────── */

    #battery.charging,
    #battery.plugged {
      color: #ebdbb2;
    }

    #battery.critical:not(.charging) {
      color: #bf616a;
      animation: blink 0.5s linear infinite alternate;
    }

    @keyframes blink {
      to {
        background: #ffffff;
        color: #000000;
      }
    }

    /* ─────────────────────────────────────────────────────────────
     * Network
     * ───────────────────────────────────────────────────────────── */

    #network.disconnected {
      color: #ebdbb2;
    }

    /* ─────────────────────────────────────────────────────────────
     * Audio
     * ───────────────────────────────────────────────────────────── */

    #pulseaudio.muted {
      color: #ebdbb2;
    }

    /* ─────────────────────────────────────────────────────────────
     * Temperature
     * ───────────────────────────────────────────────────────────── */

    #temperature.critical {
      background: #eb4d4b;
    }

    /* ─────────────────────────────────────────────────────────────
     * Tray
     * ───────────────────────────────────────────────────────────── */

    #tray {
      background: transparent;
      color: #d5c4a1;
      padding: 0 8px 0 4px;
      margin: 4px 0;
    }

    #tray > .passive {
      -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
      background: #81a1c1;
    }

    /* ─────────────────────────────────────────────────────────────
     * Keyboard
     * ───────────────────────────────────────────────────────────── */

    #language {
      background: transparent;
      color: #ebdbb2;
      padding: 0 5px;
      margin: 0 5px;
      min-width: 16px;
    }

    #keyboard-state {
      background: transparent;
      color: #ebdbb2;
      padding: 0;
      margin: 0 5px;
      min-width: 16px;
    }

    #keyboard-state > label {
      padding: 0 5px;
    }

    #keyboard-state > label.locked {
      background: rgba(0, 0, 0, 0.2);
    }

    /* ─────────────────────────────────────────────────────────────
     * Scratchpad
     * ───────────────────────────────────────────────────────────── */

    #scratchpad {
      background: rgba(0, 0, 0, 0.2);
    }

    #scratchpad.empty {
      background: transparent;
    }

    /* ─────────────────────────────────────────────────────────────
     * Custom modules
     * ───────────────────────────────────────────────────────────── */

    #custom-windowstate_0,
    #custom-windowstate_1 {
      background: rgba(73, 93, 89, 1);
      color: #ebdbb2;
      padding: 0 8px;
      border: 1px solid #a89984;
    }

    #custom-lyrics {
      color: #ebdbb2;
      margin: 0 5px;
      padding: 0 10px;
    }

    #custom-lyrics.paused {
      color: #aaaaaa;
    }
  '';
}
