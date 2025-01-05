{lib, ...}: {
  options.garden.desktop-environment = lib.mkOption {
    type = lib.types.enum ["none" "Hyprland" "sway" "awesomewm" "i3"];
    default = "none";
    description = "The desktop environment to be used.";
  };
}
