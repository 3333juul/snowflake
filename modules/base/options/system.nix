{lib, ...}: {
  options.garden.system = {
    virtualization.enable =
      lib.mkEnableOption "enables virtualization";

    # autoLogin = lib.mkOption {
    #   type = lib.types.bool;
    #   default = false;
    #   description = ''
    #     Whether to enable passwordless login. This is generally useful on systems with
    #     FDE (Full Disk Encryption) enabled. It is a security risk for systems without FDE.
    #   '';
    # };

    loginManager = lib.mkOption {
      type = lib.types.enum ["none" "greetd"];
      default = "none";
      description = "The login manager to be used.";
    };

    autoLogin.enable =
      lib.mkEnableOption "enables autologin";
  };
}
