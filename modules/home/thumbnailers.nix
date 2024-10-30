{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    sys.thumbnailers.enable = lib.mkOption {
      description = "Whether to enable thumbnailers.";
      type = lib.types.bool;
      default = true;
    };
  };
  config = lib.mkIf config.sys.thumbnailers.enable {
    # https://moritzmolch.com/blog/1749.html, https://docs.xfce.org/xfce/tumbler/available_plugins
    # note: apparently xcftools is unmaintained since 2019 and nixpkgs' version has multiple code-execution vulnerabilities, so let's not use xcf2png
    xdg.dataFile."thumbnailers/xcf.thumbnailer".text = ''
      [Thumbnailer Entry]
      TryExec=${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer
      Exec=${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -s %s -i %i -o %o -c png -f -t 10
      MimeType=video/flv;video/webm;video/mkv;video/mp4;video/mpeg;video/avi;video/ogg
      ;video/quicktime;video/x-avi;video/x-flv;video/x-mp4;video/x-mpeg;video/x-webm;v
      ideo/x-mkv;application/x-extension-webm;video/x-matroska;video/x-ms-wmv;video/x-
      msvideo;video/x-msvideo/avi;video/x-theora/ogg;video/x-theora/ogv;video/x-ms-asf
      ;video/x-m4v;
    '';
  };
}
