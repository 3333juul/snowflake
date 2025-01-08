{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.garden.environment.desktop;
in {
  config = lib.mkIf (cfg == "Hyprland") {
    home.packages = with pkgs; [
      inputs.pyprland.packages.${pkgs.system}.pyprland
    ];
    home.file.".config/hypr/pyprland.toml".text = ''
      [pyprland]
      plugins = [
      "magnify",
      "shift_monitors",
      "workspaces_follow_focus",
      ]
    '';
  };
}
