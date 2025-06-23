{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.presets.gui;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ffmpegthumbnailer
      gdk-pixbuf
    ];

    # i need this for creating thumbnails with rofi.
    # there is only a need to set up thumbnailer entry for webp, other formats work out of the box.
    xdg.dataFile."thumbnailers/gdk-pixbuf-thumbnailer.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=${pkgs.gdk-pixbuf}/bin/gdk-pixbuf-thumbnailer
      Exec=${pkgs.gdk-pixbuf}/bin/gdk-pixbuf-thumbnailer -s %s %u %o
      MimeType=x-webp;image/webp;
    '';
  };
}
