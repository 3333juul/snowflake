{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption;
  inherit (lib.types) bool;

  env = config.garden.environment;
in {
  options.garden.environment = {
    desktop = mkOption {
      type = lib.types.enum ["none" "Hyprland" "sway" "awesomewm" "i3"];
      default = "none";
      description = "The desktop environment to be used.";
    };

    isWayland = mkOption {
      type = bool;
      default = mkIf (env.desktop == "Hyprland" || env.desktop == "sway");
      defaultText = "This will default to true if a Wayland compositor has been enabled";
      description = ''
        Whether to enable Wayland exclusive modules, this contains a wariety
        of packages, modules, overlays, XDG portals and so on.

        Generally includes:
          - Wayland nixpkgs overlay
          - Wayland only services
          - Wayland only programs
          - Wayland compatible versions of packages as opposed
          to the defaults
      '';
    };
  };
}
