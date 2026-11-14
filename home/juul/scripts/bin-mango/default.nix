{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  desktop = osConfig.garden.environment.desktop.type;

  mkScript = name: script: pkgs.writeShellScriptBin name (builtins.readFile script);

  scripts = (builtins.mapAttrs mkScript {
    togglemonocle = ./togglemonocle;
  }) // {
    screenshot = pkgs.writeShellApplication {
      name = "screenshot";
      runtimeInputs = with pkgs; [
        coreutils grim slurp wayfreeze swappy wl-clipboard libnotify jq
        config.wayland.windowManager.mango.package
      ];
      text = builtins.readFile ./screenshot;
    };
  };
in {
  config = mkIf (desktop == "mango") {
    home.packages = builtins.attrValues scripts;
  };
}
