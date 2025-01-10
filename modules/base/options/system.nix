{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) enum;
in {
  options.garden.system = {
    virtualization.enable = mkEnableOption "enables virtualization";
    bluetooth.enable = mkEnableOption "Should the device load bluetooth drivers and enable blueman";
    sound.enable = mkEnableOption "Does the device have sound and its related programs be enabled";

    loginManager = {
      name = mkOption {
        type = lib.types.enum ["none" "greetd"];
        default = "none";
        description = "The login manager to be used.";
      };

      autoLogin.enable = mkEnableOption "
          Whether to enable passwordless login. This is generally useful on systems with
          FDE (Full Disk Encryption) enabled. It is a security risk for systems without FDE.
        ";
    };

    boot.loader = mkOption {
      type = enum [
        "none"
        "grub"
        "systemd-boot"
      ];
      default = "none";
      description = "The bootloader that should be used for the device.";
    };

    video = {
      enable = mkEnableOption "Does the device allow for graphical programs";
      benchmarking.enable = mkEnableOption "Enable benchmarking tools";
    };
  };
}
