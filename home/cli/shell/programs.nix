{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.environment) shell;

  cfg = osConfig.garden.programs.cli;
in {
  programs = {
    zoxide = mkIf cfg.enable {
      enable = true;
      enableZshIntegration = shell == "zsh";
      enableBashIntegration = shell == "bash";
      enableFishIntegration = shell == "fish";
      enableNushellIntegration = shell == "nushell";
    };

    atuin = mkIf cfg.enable {
      enable = true;
      enableZshIntegration = shell == "zsh";
      enableBashIntegration = shell == "bash";
      enableFishIntegration = shell == "fish";
      enableNushellIntegration = shell == "nushell";
    };

    navi = mkIf cfg.enable {
      enable = true;
      enableZshIntegration = shell == "zsh";
      enableBashIntegration = shell == "bash";
      enableFishIntegration = shell == "fish";
    };

    nix-your-shell = mkIf cfg.enable {
      enable = true;
      enableZshIntegration = shell == "zsh";
      enableFishIntegration = shell == "fish";
      enableNushellIntegration = shell == "nushell";
    };
  };
}
