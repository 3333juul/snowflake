{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.programs.tui;

  inherit (lib.modules) mkIf;
in {
  programs.yazi = mkIf cfg.yazi.enable {
    enable = true;
    #package = inputs.yazi.packages.${pkgs.system}.yazi;
    enableZshIntegration = true;

    settings = {
      manager = {
        ratio = [2 3 3];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = false;
        linemode = "none";
        show_hidden = true;
        show_symlink = true;
        scrolloff = 5;
        mouse_events = ["click" "scroll"];
        title_format = "Yazi: {cwd}";
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";
        image_filter = "triangle";
        image_quality = 75;
        sixel_fraction = 15;
        ueberzug_scale = 1;
        ueberzug_offset = [0 0 0 0];
      };

      opener = {
        edit = [
          {
            run = "nvim \"$@\"";
            desc = "$EDITOR";
            block = true;
            for = "unix";
          }
        ];
        open = [
          {
            run = "xdg-open \"$1\"";
            desc = "Open";
            for = "linux";
          }
        ];
        reveal = [
          {
            run = "xdg-open \"$(dirname \"$1\")\"";
            desc = "Reveal";
            for = "linux";
          }
          {
            run = "exiftool \"$1\"; echo \"Press enter to exit\"; read _";
            block = true;
            desc = "Show EXIF";
            for = "unix";
          }
        ];
        extract = [
          {
            run = "ya pub extract --list \"$@\"";
            desc = "Extract here";
            for = "unix";
          }
        ];
        play = [
          {
            run = "mpv --force-window \"$@\"";
            orphan = true;
            for = "unix";
          }
          {
            run = "mediainfo \"$1\"; echo \"Press enter to exit\"; read _";
            block = true;
            desc = "Show media info";
            for = "unix";
          }
        ];
        set_wallpaper = [
          {
            run = "selectwallpaper --path \"$1\"";
            desc = "Set as wallpaper";
            for = "linux";
          }
        ];
      };

      open = {
        rules = [
          {
            name = "*/";
            use = ["edit" "open" "reveal"];
          }
          {
            mime = "text/*";
            use = ["edit" "reveal"];
          }
          {
            mime = "image/*";
            use = ["open" "set_wallpaper" "reveal"];
          }
          {
            mime = "{audio,video}/*";
            use = ["play" "reveal"];
          }
          {
            mime = "application/{,g}zip";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/{json,x-ndjson}";
            use = ["edit" "reveal"];
          }
          {
            mime = "*/javascript";
            use = ["edit" "reveal"];
          }
          {
            mime = "inode/x-empty";
            use = ["edit" "reveal"];
          }
          {
            name = "*";
            use = ["open" "reveal"];
          }
        ];
      };

      tasks = {
        micro_workers = 10;
        macro_workers = 25;
        bizarre_retry = 5;
        image_alloc = 536870912;
        image_bound = [0 0];
        suppress_preload = false;
      };

      input = {
        cursor_blink = false;

        cd = {
          title = "Change directory:";
          origin = "top-center";
          offset = [0 2 50 3];
        };

        create = {
          title = "Create:";
          origin = "top-center";
          offset = [0 2 50 3];
        };

        rename = {
          title = "Rename:";
          origin = "hovered";
          offset = [0 1 50 3];
        };

        trash = {
          title = "Move {n} selected file{s} to trash? (y/N)";
          origin = "top-center";
          offset = [0 2 50 3];
        };

        delete = {
          title = "Delete {n} selected file{s} permanently? (y/N)";
          origin = "top-center";
          offset = [0 2 50 3];
        };

        filter = {
          title = "Filter:";
          origin = "top-center";
          offset = [0 2 50 3];
        };

        find = {
          title = ["Find next:" "Find previous:"];
          origin = "top-center";
          offset = [0 2 50 3];
        };

        search = {
          title = "Search via {n}:";
          origin = "top-center";
          offset = [0 2 50 3];
        };

        shell = {
          title = ["Shell:" "Shell (block):"];
          origin = "top-center";
          offset = [0 2 50 3];
        };

        overwrite = {
          title = "Overwrite an existing file? (y/N)";
          origin = "top-center";
          offset = [0 2 50 3];
        };

        quit = {
          title = "{n} task{s} running, sure to quit? (y/N)";
          origin = "top-center";
          offset = [0 2 50 3];
        };

        select = {
          open_title = "Open with:";
          open_origin = "hovered";
          open_offset = [0 1 50 7];
        };
      };

      which = {
        sort_by = "none";
        sort_sensitive = false;
        sort_reverse = false;
        sort_translit = false;
      };

      log = {
        enabled = false;
      };
    };
  };
}
