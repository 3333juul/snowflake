{config, ...}: let
  homeDir = config.home.homeDirectory;
in {
  programs.nvf.settings.vim.notes = {
    obsidian = {
      enable = true;
      setupOpts = {
        workspaces = [
          {
            name = "main";
            path = "${homeDir}/documents/knowledge/obsidian";
          }
        ];
      };
    };
  };
}
