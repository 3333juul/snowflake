{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.style) colors;

  cfg = osConfig.garden.programs.gui;
in {
  config = mkIf cfg.rofi.enable {
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

    home.file.".config/rofi/colors.rasi".text = ''
      * {
      background:            #${colors.base00}E6;
      foreground:            #${colors.base06};
      regular0:              #${colors.base03};
      regular1:              #${colors.base08};
      regular2:              #${colors.base0B};
      regular3:              #${colors.base0A};
      regular4:              #${colors.base0D};
      regular5:              #${colors.base0E};
      regular6:              #${colors.base0C};
      regular7:              #${colors.base06};
      bright0:               #${colors.base04};
      bright1:               #${colors.base08};
      bright2:               #${colors.base0B};
      bright3:               #${colors.base0A};
      bright4:               #${colors.base0D};
      bright5:               #${colors.base0F};
      bright6:               #${colors.base0C};
      bright7:               #${colors.base07};
      }
    '';

    # Symlink all themes - the argument of this function must be a full path, not a Nix path type, otherwise it won't work
    xdg.configFile."rofi/themes" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/gui/launcher/rofi/themes";
      recursive = true;
    };
  };
}
