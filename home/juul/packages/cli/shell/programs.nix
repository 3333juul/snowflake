{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.presets.cli;
in {
  programs = {
    zoxide = mkIf cfg.enable {
      enable = true;
    };

    atuin = mkIf cfg.enable {
      enable = true;
    };

    navi = mkIf cfg.enable {
      enable = true;
    };

    # nix-your-shell = mkIf cfg.enable {
    #   enable = true;
    # };
  };
}
