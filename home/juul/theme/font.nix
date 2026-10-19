{
  lib,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.validators) hasProfile;
in {
  config = mkIf (hasProfile osConfig ["graphical"]) {
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      nerd-fonts.iosevka
      nerd-fonts.terminess-ttf

      twemoji-color-font
      noto-fonts-color-emoji
      terminus_font
      terminus_font_ttf
      font-awesome
      noto-fonts

      #noto-fonts-color-emoji
      #material-icons
      #material-design-icons
    ];
  };
}
