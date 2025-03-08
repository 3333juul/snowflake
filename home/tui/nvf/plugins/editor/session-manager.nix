{config, ...}: let
  inherit (config.home) homeDirectory;
in {
  programs.nvf.settings.vim = {
    session.nvim-session-manager = {
      enable = true;
      setupOpts = {
        autoload_mode = "CurrentDir";
        autosave_ignore_dirs = [homeDirectory];
      };
    };
    # Huge delay if using nvim-session-manager.mappings.loadSession
    keymaps = [
      {
        key = "<leader>sm";
        mode = "n";
        desc = "Load session";
        action = "<cmd>SessionManager load_session<cr>";
      }
    ];
  };
}
