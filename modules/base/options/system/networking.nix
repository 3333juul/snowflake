{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) bool listOf str enum;

  sys = config.garden.system.networking;
  cfg = sys.tailscale;
in {
  options.garden.system.networking = {
    wirelessBackend = mkOption {
      type = enum [
        "iwd"
        "wpa_supplicant"
      ];
      default = "wpa_supplicant";
      description = ''
        Backend that will be used for wireless connections using either `networking.wireless`
        or `networking.networkmanager.wifi.backend`
        Defaults to wpa_supplicant until iwd is stable.
      '';
    };

    tailscale = {
      enable = mkEnableOption "Tailscale VPN";

      defaultFlags = mkOption {
        type = listOf str;
        default = ["--ssh"];
        description = ''
          A list of command-line flags that will be passed to the Tailscale daemon on startup
          using the {option}`config.services.tailscale.extraUpFlags`.
          If `isServer` is set to true, the server-specific values will be appended to the list
          defined in this option.
        '';
      };

      isClient = mkOption {
        type = bool;
        default = cfg.enable;
        example = true;
        description = ''
          Whether the target host should utilize Tailscale client features";
          This option is mutually exclusive with {option}`tailscale.isServer` as they both
          configure Taiscale, but with different flags
        '';
      };

      isServer = mkOption {
        type = bool;
        default = !cfg.isClient;
        example = true;
        description = ''
          Whether the target host should utilize Tailscale server features.
          This option is mutually exclusive with {option}`tailscale.isClient` as they both
          configure Taiscale, but with different flags
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # server can't be client and client be server
    assertions = [
      (mkIf (cfg.isClient == cfg.isServer) {
        assertion = false;
        message = ''
          You have enabled both client and server features of the Tailscale service. Unless you are providing your own UpFlags, this is probably not what you want.
        '';
      })
    ];
  };
}
