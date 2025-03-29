{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.lists) optionals;
  inherit (config.services) tailscale;

  sys = config.garden.system.networking;
  cfg = sys.tailscale;
in {
  config = mkIf cfg.enable {
    # make the tailscale command usable to users
    environment.systemPackages = [pkgs.tailscale];

    networking.firewall = {
      # always allow traffic from your Tailscale network
      trustedInterfaces = ["${tailscale.interfaceName}"];
      checkReversePath = "loose";

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [tailscale.port];
    };

    # enable tailscale, inter-machine VPN service
    services.tailscale = {
      enable = true;
      permitCertUid = "root";
      useRoutingFeatures = mkDefault "server";
      extraUpFlags =
        sys.tailscale.defaultFlags
        ++ optionals sys.tailscale.enable ["--advertise-exit-node"];
    };
  };
}
