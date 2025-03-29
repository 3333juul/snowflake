{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption;
  inherit (lib.types) listOf str;

  cfg = config.garden.system.fs.support;
in {
  options.garden.system = {
    fs.support = mkOption {
      type = listOf str;
      default = [
        "vfat"
        "ext4"
      ];
      description = ''
        A list of filesystems available supported by the system
        it will enable services based on what strings are found in the list.

        It would be a good idea to keep vfat and ext4 so you can mount USBs.
      '';
    };
  };

  config.warnings = mkIf (cfg == []) [
    ''
      You have not set any filesystems in your configuration. This is not recommended
      as it may lead to a unusable system.

      Please set {option}`config.garden.system.fs` in your configuration to remedy this.
    ''
  ];
}
