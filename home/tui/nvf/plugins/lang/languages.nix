# {osConfig, ...}: let
#   inherit (osConfig.garden.environment) flakePath;
#   inherit (osConfig.networking) hostName;
# in {
{
  programs.nvf.settings.vim = {
    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableLSP = true;
      enableTreesitter = true;

      bash.enable = true;
      lua.enable = true;
      python.enable = true;

      nix = {
        enable = true;
        # TODO:
        # lsp = {
        #   server = "nixd";
        #   options = {
        #     nixos = {
        #       expr = "(builtins.getFlake ${flakePath}).nixosConfigurations.${hostName}.options";
        #     };
        #   };
        # };
      };

      rust = {
        enable = false;
        crates.enable = false;
      };

      markdown = {
        enable = true;
        format.type = "prettierd";
      };
    };
  };
}
