{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.garden) services;
in {
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [
      ];

      allowedTCPPortRanges = mkIf services.kdeconnect.enable [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = mkIf services.kdeconnect.enable [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
}
