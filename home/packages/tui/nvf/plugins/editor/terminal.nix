{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  programs.nvf.settings.vim = {
    terminal.toggleterm = {
      enable = true;

      mappings.open = "<c-t>";
      setupOpts = {
        winbar.enabled = false;
        direction = "float";

        float_opts = {
          width = mkLuaInline ''
            function()
              return math.floor(vim.o.columns * 0.95)
            end
          '';
          height = mkLuaInline ''
            function()
              return math.floor(vim.o.lines * 0.95)
            end
          '';
        };
      };

      lazygit = {
        enable = true;
        mappings.open = "<leader>gl";
      };
    };
  };
}
