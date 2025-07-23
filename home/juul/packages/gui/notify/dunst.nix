{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (osConfig.garden.environment) isWM;
  inherit (osConfig.garden.programs) defaults;
in {
  config = mkIf (isWM && defaults.notifs == "dunst") {
    services.dunst = {
      enable = true;
      # TODO:
    };
  };
}
