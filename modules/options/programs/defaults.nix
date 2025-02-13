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
      default = "brave";
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

    image-viewer = mkOption {
      type = enum [
        "vimiv"
        "pqiv"
        "viewnior"
        "swayimg"
      ];
      default = "vimiv";
    };

    # noiseSuppressor = mkOption {
    #   type = nullOr (enum [
    #     "rnnoise"
    #     "noisetorch"
    #   ]);
    #   default = "rnnoise";
    #   description = ''
    #     The noise suppressor to be used for desktop systems with sound enabled.
    #   '';
    # };
  };
}
