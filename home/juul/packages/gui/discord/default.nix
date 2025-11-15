{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = osConfig.garden.programs;
  # userSettings = {
  #   plugins = {
  #     BetterNotesBox.enabled = false;
  #     ShowHiddenChannels.enabled = false;
  #     YoutubeAdblock.enabled = true;
  #     BetterGifPicker.enabled = true;
  #     SpotifyControls.enabled = false;
  #   };
  # };
in {
  config = mkIf cfg.discord.enable {
    home.packages = with pkgs; [
      (discord.override {
        withVencord = true;
      })

      vesktop
    ];

    xdg.configFile."Vencord/themes/gruvbox.theme.css".source = ./gruvbox.css;
    # xdg.configFile."Vencord/settings/settings.json".text = builtins.toJSON userSettings;
  };
}
