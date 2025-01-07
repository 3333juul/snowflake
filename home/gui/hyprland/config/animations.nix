{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.76, 0.42, 0.74, 0.87"
        "winOut, 0.76, 0.42, 0.74, 0.87"
        "workIn, 0.72, -0.07, 0.41, 0.98"
        "linear, 1, 1, 1, 1"
      ];
      animation = [
        "windows, 1, 1.5, wind, popin"
        "windowsIn, 1, 1.5, workIn, popin"
        "windowsOut, 1, 1.5, workIn, popin"
        "windowsMove, 1, 1.5, wind, slide"
        "fadeIn, 1, 1.5, winIn"
        "fadeOut, 1, 1.5, winOut"
        "workspaces, 1, 1.5, workIn, slide"
        "specialWorkspace, 1, 2, workIn, slidevert"
      ];
    };
  };
}
