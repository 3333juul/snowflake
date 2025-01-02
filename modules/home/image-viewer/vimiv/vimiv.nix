{
  pkgs,
  lib,
  ...
}: let
  settings = {
    GENERAL = {
      monitor_filesystem = true;
      startup_library = true;
      style = "gruvbox";
      read_only = false;
    };

    COMMAND = {
      history_limit = 100;
    };

    COMPLETION = {
      fuzzy = false;
    };

    SEARCH = {
      ignore_case = true;
      incremental = true;
    };

    IMAGE = {
      autoplay = true;
      autowrite = "ask";
      overzoom = 1.0;
      zoom_wheel_ctrl = true;
    };

    LIBRARY = {
      width = 0.3;
      show_hidden = false;
    };

    THUMBNAIL = {
      size = 128;
      save = true;
    };

    SLIDESHOW = {
      delay = 2.0;
      indicator = "slideshow:";
    };

    STATUSBAR = {
      collapse_home = true;
      show = true;
      message_timeout = 60000;
      mark_indicator = "<b>*</b>";
      left = "{pwd}{read-only}";
      left_image = "{index}/{total} {basename}{read-only} [{zoomlevel}]";
      left_thumbnail = "{thumbnail-index}/{thumbnail-total} {thumbnail-basename}{read-only}";
      left_manipulate = "{basename} {image-size} Modified: {modified} {processing}";
      center_thumbnail = "{thumbnail-size}";
      center = "{slideshow-indicator} {slideshow-delay} {transformation-info}";
      right = "{keys} {mark-count} {mode}";
      right_image = "{keys} {mark-indicator} {mark-count} {mode}";
    };

    KEYHINT = {
      delay = 500;
      timeout = 5000;
    };

    TITLE = {
      fallback = "vimiv";
      image = "vimiv - {basename}";
    };

    METADATA = {
      keys1 = "Exif.Image.Make,Exif.Image.Model,Exif.Photo.LensModel,Exif.Image.DateTime,Exif.Image.Artist,Exif.Image.Copyright";
      keys2 = "Exif.Photo.ExposureTime,Exif.Photo.FNumber,Exif.Photo.ISOSpeedRatings,Exif.Photo.ApertureValue,Exif.Photo.ExposureBiasValue,Exif.Photo.FocalLength,Exif.Photo.ExposureProgram";
      keys3 = "Exif.GPSInfo.GPSLatitudeRef,Exif.GPSInfo.GPSLatitude,Exif.GPSInfo.GPSLongitudeRef,Exif.GPSInfo.GPSLongitude,Exif.GPSInfo.GPSAltitudeRef,Exif.GPSInfo.GPSAltitude";
      keys4 = "Iptc.Application2.Caption,Iptc.Application2.Keywords,Iptc.Application2.City,Iptc.Application2.SubLocation,Iptc.Application2.ProvinceState,Iptc.Application2.CountryName,Iptc.Application2.Source,Iptc.Application2.Credit,Iptc.Application2.Copyright,Iptc.Application2.Contact";
      keys5 = "Exif.Image.ImageWidth,Exif.Image.ImageLength,Exif.Photo.PixelXDimension,Exif.Photo.PixelYDimension,Exif.Image.BitsPerSample,Exif.Image.Compression,Exif.Photo.ColorSpace";
    };

    SORT = {
      image_order = "alphabetical";
      directory_order = "alphabetical";
      reverse = false;
      ignore_case = false;
      shuffle = false;
    };

    PLUGINS = {
      print = "default";
      metadata = "default";
    };

    ALIASES = {};
  };
in {
  home.packages = with pkgs; [vimiv-qt];
  xdg.configFile."vimiv/vimiv.conf".text = lib.generators.toINI {} settings;
}
