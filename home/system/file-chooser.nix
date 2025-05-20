{pkgs, ...}: {
  xdg = {
    configFile.".config/xdg-desktop-portal-termfilechooser/config".text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      default_dir=$HOME
      env=TERMCMD=kitty --app-id="kitty.yazi.filechooser"
    '';

    configFile.".config/xdg-desktop-portal/portals.conf".text = ''
      [preferred]
      org.freedesktop.impl.portal.FileChooser=termfilechooser
    '';
  };
}
