{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum nullOr;
in {
  options.garden.programs.defaults = {
    shell = mkOption {
      type = enum [
        "bash"
        "zsh"
        "fish"
        "nushell"
      ];
      default = "zsh";
    };

    terminal = mkOption {
      type = enum [
        "alacritty"
        "kitty"
        "wezterm"
        "foot"
      ];
      default = "kitty";
    };

    fileManager = mkOption {
      type = enum [
        "yazi"
        "thunar"
        "dolphin"
        "nemo"
      ];
      default = "yazi";
    };

    browser = mkOption {
      type = enum [
        "brave"
        "chromium"
        "firefox"
        "zen"
      ];
      default = "zen";
    };

    editor = mkOption {
      type = enum [
        "nvim"
        "codium"
      ];
      default = "nvim";
    };

    launcher = mkOption {
      type = nullOr (enum [
        "rofi"
        "tofi"
        "cosmic-launcher"
      ]);
      default = "tofi";
    };

    bar = mkOption {
      type = nullOr (enum [
        "waybar"
        "ags"
      ]);
      default = "waybar";
    };

    screenLocker = mkOption {
      type = nullOr (enum [
        "hyprlock"
        "swaylock"
        "gtklock"
        "cosmic-greeter"
      ]);
      default = "hyprlock";
      description = ''
        The lockscreen module to be loaded by home-manager.
      '';
    };

    imageViewer = mkOption {
      type = enum [
        "vimiv"
        "pqiv"
        "viewnior"
        "swayimg"
      ];
      default = "vimiv";
    };
  };
}
