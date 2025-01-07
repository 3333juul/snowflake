{
  pkgs,
  config,
  ...
}: {
  programs.yazi.theme = {
    manager = {
      cwd = {fg = "cyan";};

      hovered = {
        fg = "black";
        bg = "green";
        bold = true;
      };
      preview_hovered = {underline = true;};

      find_keyword = {
        fg = "yellow";
        italic = true;
      };
      find_position = {
        fg = "magenta";
        bg = "reset";
        italic = true;
      };

      marker_copied = {
        fg = "green";
        bg = "green";
      };
      marker_cut = {
        fg = "lightred";
        bg = "lightred";
      };
      marker_marked = {
        fg = "lightyellow";
        bg = "lightyellow";
      };
      marker_selected = {
        fg = "blue";
        bg = "blue";
      };

      tab_active = {
        fg = "black";
        bg = "white";
      };
      tab_inactive = {
        fg = "white";
        bg = "red";
      };
      tab_width = 1;

      count_copied = {
        fg = "black";
        bg = "green";
      };
      count_cut = {
        fg = "black";
        bg = "lightred";
      };
      count_selected = {
        fg = "black";
        bg = "blue";
      };

      border_symbol = "│";
      border_style = {fg = "gray";};

      syntect_theme = "";
    };

    status = {
      separator_open = "";
      separator_close = "";
      separator_style = {
        fg = "black";
        bg = "black";
      };

      mode_normal = {
        fg = "black";
        bg = "white";
        bold = true;
      };
      mode_select = {
        fg = "black";
        bg = "green";
        bold = true;
      };
      mode_unset = {
        fg = "black";
        bg = "magenta";
        bold = true;
      };

      progress_label = {bold = true;};
      progress_normal = {
        fg = "blue";
        bg = "black";
      };
      progress_error = {
        fg = "red";
        bg = "black";
      };

      permissions_t = {fg = "green";};
      permissions_r = {fg = "lightyellow";};
      permissions_w = {fg = "lightred";};
      permissions_x = {fg = "lightcyan";};
      permissions_s = {fg = "darkgray";};
    };

    select = {
      border = {fg = "blue";};
      active = {fg = "magenta";};
      inactive = {};
    };

    input = {
      border = {fg = "blue";};
      title = {};
      value = {};
      selected = {reversed = true;};
    };

    completion = {
      border = {fg = "blue";};
      active = {bg = "darkgray";};
      inactive = {};

      icon_file = "";
      icon_folder = "";
      icon_command = "";
    };

    tasks = {
      border = {fg = "blue";};
      title = {};
      hovered = {underline = true;};
    };

    which = {
      cols = 3;
      mask = {bg = "black";};
      cand = {fg = "lightcyan";};
      rest = {fg = "darkgray";};
      desc = {fg = "magenta";};
      separator = "  ";
      separator_style = {fg = "darkgray";};
    };

    help = {
      on = {fg = "magenta";};
      run = {fg = "cyan";};
      desc = {fg = "white";};
      hovered = {
        reversed = true;
        bold = true;
      };
      footer = {
        fg = "black";
        bg = "white";
      };
    };

    filetype = {
      rules = [
        {
          mime = "image/*";
          fg = "cyan";
        }
        {
          mime = "video/*";
          fg = "yellow";
        }
        {
          mime = "audio/*";
          fg = "yellow";
        }
        {
          mime = "application/zip";
          fg = "magenta";
        }
        {
          mime = "application/gzip";
          fg = "magenta";
        }
        {
          mime = "application/x-tar";
          fg = "magenta";
        }
        {
          mime = "application/x-bzip";
          fg = "magenta";
        }
        {
          mime = "application/x-bzip2";
          fg = "magenta";
        }
        {
          mime = "application/x-7z-compressed";
          fg = "magenta";
        }
        {
          mime = "application/x-rar";
          fg = "magenta";
        }
        {
          mime = "application/xz";
          fg = "magenta";
        }
        # Documents
        {
          mime = "application/doc";
          fg = "green";
        }
        {
          mime = "application/pdf";
          fg = "green";
        }
        {
          mime = "application/rtf";
          fg = "green";
        }
        {
          mime = "application/vnd.*";
          fg = "green";
        }
        # Fallback
        {
          name = "*/";
          fg = "blue";
          bold = true;
        }
      ];
    };
  };
}
