{
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.environment.desktop.type;
in {
  config = mkIf (cfg == "Hyprland") {
    home.packages = [
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
