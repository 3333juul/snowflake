{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) enum listOf str;
in {
  options.garden.system = {
    bluetooth.enable = mkEnableOption "Should the device load bluetooth drivers and enable blueman";
    sound.enable = mkEnableOption "Does the device have sound and its related programs be enabled";

    loginManager = {
      name = mkOption {
        type = enum ["none" "greetd"];
        default = "none";
        description = "The login manager to be used.";
      };

      autoLogin.enable = mkEnableOption ''
        Whether to enable passwordless login. This is generally useful on systems with
        FDE (Full Disk Encryption) enabled. It is a security risk for systems without FDE.
      '';
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

    virtualization = {
      enable = mkEnableOption "Should the device be allowed to virtualizle processes";
      docker.enable = mkEnableOption "docker";
      podman.enable = mkEnableOption "podman";
      qemu.enable = mkEnableOption "qemu";
      distrobox.enable = mkEnableOption "distrobox";
      waydroid.enable = mkEnableOption "waydroid";
    };

    printing = {
      enable = mkEnableOption "printing";

      extraDrivers = mkOption {
        type = listOf str;
        default = [];
        description = "A list of additional drivers to install for printing";
      };
    };
  };
}
