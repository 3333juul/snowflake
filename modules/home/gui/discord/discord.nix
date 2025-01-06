{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.gui;
in {
  config = lib.mkIf cfg.discord.enable {
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
