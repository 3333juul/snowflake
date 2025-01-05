{pkgs, ...}: {
  home.packages = with pkgs; [
    xfce.thunar
    xfce.xfconf
    xfce.tumbler
  ];

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';
}
