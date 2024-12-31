{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    nerd-fonts.iosevka
    nerd-fonts.terminess-ttf

    twemoji-color-font
    noto-fonts-emoji
    terminus_font
    terminus_font_ttf
    terminus-nerdfont
    font-awesome
    noto-fonts

    #noto-fonts-color-emoji
    #material-icons
    #material-design-icons
  ];
}
