{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.environment.desktop.type;
in {
  # TODO: Change to isWayland, remove variables not associated with wayland
  environment.variables = mkIf (cfg == "Hyprland") {
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    ANKI_WAYLAND = "1";
    MOZ_ENABLE_WAYLAND = "1";

    GDK_BACKEND = "wayland,x11";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # __GL_GSYNC_ALLOWED = "0";
    # __GL_VRR_ALLOWED = "0";
    # WLR_DRM_NO_ATOMIC = "1";
    # WLR_BACKEND = "vulkan";
    # WLR_RENDERER = "vulkan";
  };
}
