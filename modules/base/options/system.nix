{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
in {
  options.garden.system = {
    virtualization.enable = mkEnableOption "enables virtualization";

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

    bluetooth.enable = mkEnableOption "Should the device load bluetooth drivers and enable blueman";

    sound.enable = mkEnableOption "Does the device have sound and its related programs be enabled";
  };
}
