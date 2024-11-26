{pkgs, ...}: {
  # xdg.dataFile."thumbnailers/ffmpegthumbnailer.thumbnailer".text = ''
  #   [Thumbnailer Entry]
  #   TryExec=${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer
  #   Exec=${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i %i -o %o -s %s -f
  #   MimeType=video/3gpp;video/3gpp2;video/annodex;video/dv;video/isivideo;video/mj2;video/mp2t;video/mp4;video/mpeg;video/ogg;video/quicktime;video/vnd.avi;video/vnd.mpegurl;video/vnd.radgamettools.bink;video/vnd.radgamettools.smacker;video/vnd.rn-realvideo;video/vnd.vivo;video/vnd.youtube.yt;video/wavelet;video/webm;video/x-anim;video/x-flic;video/x-flv;video/x-javafx;video/x-matroska;video/x-matroska-3d;video/x-mjpeg;video/x-mng;video/x-ms-wmv;video/x-nsv;video/x-ogm+ogg;video/x-sgi-movie;video/x-theora+ogg;application/mxf;application/vnd.ms-asf;application/vnd.rn-realmedia;application/x-matroska;application/ogg;
  # '';

  xdg.dataFile."thumbnailers/gdk-pixbuf-thumbnailer.thumbnailer".text = ''
    [Thumbnailer Entry]
    TryExec=gdk-pixbuf-thumbnailer
    Exec=gdk-pixbuf-thumbnailer -s %s %u %o
    MimeType=application/x-navi-animation;image/png;image/bmp;image/x-bmp;image/x-MS-bmp;image/gif;image/x-icon;image/x-ico;image/x-win-bitmap;image/vnd.microsoft.icon;application/ico;image/ico;image/icon;text/ico;image/jpeg;image/x-portable-anymap;image/x-portable-bitmap;image/x-portable-graymap;image/x-portable-pixmap;image/tiff;image/x-xpixmap;image/x-xbitmap;image/x-tga;image/x-icns;image/x-quicktime;image/qtif;image/x-webp;image/webp;
  '';
}
