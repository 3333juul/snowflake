{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.garden.cli.bat.enable {
    programs.bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "gruvbox-dark";
      };
      extraPackages = with pkgs.bat-extras; [
        batman
        batpipe
        batgrep
        # batdiff
      ];
    };
  };
}
