{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.environment) isWayland;

  # inherit (inputs.nvf.lib.nvim.dag) entryAfter entryBefore;

  cfg = osConfig.garden.programs.editor;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./plugins
    ./mappings.nix
  ];

  config = mkIf cfg.neovim.enable {
    xdg.desktopEntries = {
      nvim = {
        name = "Neovim";
        type = "Application";
        icon = "nvim";
        exec = "${pkgs.kitty}/bin/kitty nvim %F";
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        preventJunkFiles = true;
        options = {
          # make indents normal
          tabstop = 2;
          shiftwidth = 2;
          softtabstop = 2;
        };

        clipboard = {
          enable = true;
          providers.wl-copy.enable = isWayland;
          providers.xclip.enable = !isWayland;
        };
      };
    };
  };
}
