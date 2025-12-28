{
  wayland.windowManager.mango = {
    settings = ''
      # exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY
      exec-once=systemctl --user start waybar
      exec-once=systemctl --user start hyprpaper
      exec-once=vicinae server
    '';
  };
}
