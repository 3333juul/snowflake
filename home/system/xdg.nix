{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (pkgs.stdenv) isLinux;
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) mapAttrsToList nameValuePair optionalAttrs;
  inherit (lib.lists) flatten;
  inherit (osConfig.garden.programs) defaults;
  inherit (builtins) listToAttrs;

  homeDir = config.home.homeDirectory;

  defaultApps = {
    browser = ["${defaults.browser}.desktop"];
    text = ["nvim.desktop"];
    image = ["${defaults.imageViewer}.desktop"];
    audio = ["mpv.desktop"];
    video = ["mpv.desktop"];
    directory = ["thunar.desktop"];
    office = ["libreoffice.desktop"];
    pdf = ["org.gnome.Evince.desktop"];
    terminal = ["${defaults.terminal}.desktop"];
    archive = ["org.gnome.FileRoller.desktop"];
    mail = ["thunderbird.desktop"];
  };

  mimeMap = {
    text = [
      "application/json"
      "text/english"
      "text/plain"
      "text/markdown"
      "text/x-makefile"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "application/x-shellscript"
      "text/x-c"
      "text/x-c++"
      # empty files: https://askubuntu.com/questions/1526501/why-are-my-empty-files-not-being-assigned-the-correct-mimetype
      "application/x-zerosize"
    ];
    image = [
      "image/bmp"
      "image/gif"
      "image/jpeg"
      "image/jpg"
      "image/png"
      "image/svg+xml"
      "image/tiff"
      "image/vnd.microsoft.icon"
      "image/webp"
    ];
    audio = [
      "audio/aac"
      "audio/mpeg"
      "audio/ogg"
      "audio/opus"
      "audio/wav"
      "audio/webm"
      "audio/x-matroska"
    ];
    video = [
      "video/mp2t"
      "video/mp4"
      "video/mpeg"
      "video/ogg"
      "video/webm"
      "video/x-flv"
      "video/x-matroska"
      "video/x-msvideo"
    ];
    directory = ["inode/directory"];
    browser = [
      "text/html"
      "x-scheme-handler/about"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/unknown"
    ];
    office = [
      "application/vnd.oasis.opendocument.text"
      "application/vnd.oasis.opendocument.spreadsheet"
      "application/vnd.oasis.opendocument.presentation"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"
      "application/msword"
      "application/vnd.ms-excel"
      "application/vnd.ms-powerpoint"
      "application/rtf"
    ];
    pdf = ["application/pdf"];
    terminal = ["terminal"];
    archive = [
      "application/zip"
      "application/rar"
      "application/7z"
      "application/*tar"
    ];
    mail = [
      "x-scheme-handler/mailto"
      "x-scheme-handler/mid"
      "message/rfc822"
    ];
  };

  associations = listToAttrs (
    flatten (mapAttrsToList (key: map (type: nameValuePair type defaultApps."${key}")) mimeMap)
  );
in {
  xdg = {
    mimeApps = {
      enable = isLinux;
      associations.added = associations;
      defaultApplications = associations;
    };

    cacheHome = "${homeDir}/.cache";
    configHome = "${homeDir}/.config";
    dataHome = "${homeDir}/.local/share";
    stateHome = "${homeDir}/.local/state";

    userDirs = mkIf isLinux {
      enable = true;
      createDirectories = true;

      documents = "${homeDir}/documents";
      download = "${homeDir}/downloads";
      desktop = "${homeDir}/.local/user/desktop";
      videos = "${homeDir}/media/videos";
      music = "${homeDir}/media/music";
      pictures = "${homeDir}/media/pictures";
      publicShare = "${homeDir}/.local/user/public/share";
      templates = "${homeDir}/.local/user/templates";

      extraConfig =
        {
          XDG_PROJECTS_DIR = "${homeDir}/projects";
          XDG_TORRENTS_DIR = "${homeDir}/downloads/torrents";
          XDG_SCREENSHOTS_DIR = "${homeDir}/media/pictures/screenshots";
          XDG_WALLPAPERS_DIR = "${homeDir}/media/pictures/wallpapers";
          XDG_RECORDINGS_DIR = "${homeDir}/media/videos/recordings";
        }
        // optionalAttrs osConfig.garden.programs.gaming.enable {
          XDG_GAMES_DIR = "${homeDir}/media/games";
        };
    };

    configFile = {
      # because https://github.com/nix-community/home-manager/issues/1213
      "mimeapps.list".force = true;

      # needed to disable creating .npm in home directory
      "npm/npmrc".text = ''
        prefix=''${XDG_DATA_HOME}/npm
        cache=''${XDG_CACHE_HOME}/npm
        init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
      '';

      # set default terminal for thunar
      "xfce4/helpers.rc".text = ''
        TerminalEmulator=kitty
      '';
    };
  };

  home.sessionVariables = {
    # prevent wine from creating file associations
    WINEDLLOVERRIDES = "winemenubuilder.exe=d";
  };
}
