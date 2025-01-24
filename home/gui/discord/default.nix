{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = osConfig.garden.programs.gui;
in {
  config = mkIf cfg.discord.enable {
    home.packages = with pkgs; [
      # discord
      (discord.override {
        withVencord = true;
      })
      vesktop
    ];
    xdg.configFile."Vencord/themes/gruvbox.theme.css".source = ./gruvbox.css;
  };
}
