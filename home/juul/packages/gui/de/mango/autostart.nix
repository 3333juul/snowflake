{
  wayland.windowManager.mango = {
    autostart_sh = ''
      systemctl --user start waybar
      systemctl --user start swaybg
    '';
  };
}
