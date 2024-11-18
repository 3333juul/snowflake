{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraCode"
        "NerdFontsSymbolsOnly"
        "Iosevka"
      ];
    })
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
