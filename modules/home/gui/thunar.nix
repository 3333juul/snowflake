{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.gui;
in {
  config = lib.mkIf cfg.thunar.enable {
    home.packages = with pkgs; [
      xfce.thunar
      xfce.xfconf
      xfce.tumbler
    ];

    xdg.configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=kitty
    '';
  };
}
