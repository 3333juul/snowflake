{lib, ...}: let
  inherit (lib.options) mkEnableOption mkOption;
in {
  options.garden.system = {
    virtualization.enable =
      mkEnableOption "enables virtualization";

    # autoLogin = lib.mkOption {
    #   type = lib.types.bool;
    #   default = false;
    #   description = ''
    #     Whether to enable passwordless login. This is generally useful on systems with
    #     FDE (Full Disk Encryption) enabled. It is a security risk for systems without FDE.
    #   '';
    # };
    loginManager = {
      name = mkOption {
        type = lib.types.enum ["none" "greetd"];
        default = "none";
        description = "The login manager to be used.";
      };

      autoLogin.enable =
        mkEnableOption "enables autologin";
    };

    bluetooth.enable = mkEnableOption "Should the device load bluetooth drivers and enable blueman";
  };
}
