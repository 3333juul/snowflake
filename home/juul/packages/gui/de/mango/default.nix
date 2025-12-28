{
  inputs,
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.environment.desktop;
in {
  imports = [
    inputs.mango.hmModules.mango
    ./animations.nix
    ./autostart.nix
    ./binds.nix
    ./look.nix
    ./options.nix
    ./rules.nix
  ];

  config = mkIf (cfg.type == "mango") {
    wayland.windowManager.mango = {
      enable = true;
    };
  };
}
