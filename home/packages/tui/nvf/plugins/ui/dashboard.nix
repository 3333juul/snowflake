{
  programs.nvf.settings.vim = {
    dashboard.dashboard-nvim = {
      enable = true;

      setupOpts = {
        theme = "doom";
        config = {
          header = [
            "                                                       "
            "                                                       "
            "                                                       "
            " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗"
            " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║"
            " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║"
            " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║"
            " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║"
            " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝"
            "                                                       "
            "                                                       "
            "                                                       "
          ];
          center = [
            {
              icon = "  ";
              icon_hl = "Number";
              desc = "sessions              ";
              desc_hl = "String";
              key = "s";
              key_hl = "Number";
              action = "SessionManager load_session";
            }
            {
              icon = "  ";
              icon_hl = "Number";
              desc = "find files            ";
              desc_hl = "String";
              key = "f";
              key_hl = "Number";
              action = "Telescope find_files";
            }
            {
              icon = "  ";
              icon_hl = "Number";
              desc = "recent files          ";
              desc_hl = "String";
              key = "r";
              key_hl = "Number";
              action = "Telescope oldfiles";
            }
          ];
          footer = {};
        };
      };
    };
  };
}
