{lib, ...}: {
  options.garden = {
    desktop = lib.mkOption {
      type = lib.types.enum ["none" "Hyprland" "sway" "awesomewm" "i3"];
      default = "none";
      description = "The desktop environment to be used.";
    };

    autostart.enable =
      lib.mkEnableOption "autostart";
  };
}
