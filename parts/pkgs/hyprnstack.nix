{
  lib,
  fetchFromGitHub,
  hyprland,
  hyprlandPlugins,
  pkg-config,
}:
hyprlandPlugins.mkHyprlandPlugin hyprland {
  pluginName = "hyprNStack";
  version = "0eb3c1fee1f33c632498dc598488412133ca5e3c";

  src = fetchFromGitHub {
    owner = "zakk4223";
    repo = "hyprNStack";
    rev = "0eb3c1fee1f33c632498dc598488412133ca5e3c";
    hash = "sha256-0ZLPe6dRbLqHGj8yssP1EGNUnHJKe1fIJCqypTuhg5E=";
  };

  # Native build tools required for the plugin
  nativeBuildInputs = [pkg-config]; # nie jestem tego pewnien czy to jest potrzebne

  # Set additional build inputs if required
  # Hyprland and its dependencies are included by default
  buildInputs = [];

  # Metadata about the plugin
  meta = {
    homepage = "https://github.com/zakk4223/hyprNStack";
    description = "Hyprland plugin for N-stack layout";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
