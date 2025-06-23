{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption;

  cfg = config.garden.programs;
in {
  # these are options that will cause a mass rebuild by enabling multiple packages
  options.garden.presets = {
    cli.enable = mkEnableOption "Enable CLI programs" // {default = true;};
    tui.enable = mkEnableOption "Enable TUI programs" // {default = cfg.cli.enable;};
    gui.enable = mkEnableOption "Enable GUI programs";

    work.enable = mkEnableOption "Enable work programs";
    gaming.enable = mkEnableOption "Enable gaming programs";
    gamingFull.enable = mkEnableOption "Enable gaming programs";
  };
}
