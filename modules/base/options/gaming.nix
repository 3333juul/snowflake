{lib, ...}: let
  inherit (lib.options) mkEnableOption;
in {
  options.garden.programs.gaming = {
    enable = mkEnableOption "enables gaming programs";
    lutris.enable = mkEnableOption "enables lutris";
    minecraft.enable = mkEnableOption "enable minecraft";
    steam.enable = mkEnableOption "enables steam";
  };
}
