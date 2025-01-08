{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.garden.programs.gui;
in {
  config = lib.mkIf cfg.rofi.enable {
    programs.rofi = {
      enable = true;
      #package = pkgs.callPackage ../../../pkgs/rofi.nix {};
      package = pkgs.rofi-wayland;
      extraConfig = {
        show-icons = true;
        icon-theme = "Zafiro";
        terminal = "kitty";
        cycle = true;
        hide-scrollbar = true;
        disable-history = false;
        kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
        kb-row-down = "Down,Control+j";
        kb-row-left = "Control+h";
        kb-row-right = "Control+l";
        kb-accept-entry = "Control+m,Return,KP_Enter";
        kb-remove-to-eol = "Control+Shift+e";
        kb-mode-next = "Shift+Right,Control+Tab";
        kb-mode-previous = "Shift+Left,Control+Shift+Tab";
        kb-remove-char-back = "BackSpace";
        kb-mode-complete = "Control+t";
      };
    };

    # Symlink all themes - the argument of this function must be a full path, not a Nix path type, otherwise it won't work
    xdg.configFile."rofi/themes" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/gui/rofi/themes";
      recursive = true;
    };
  };
}
