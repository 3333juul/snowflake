{
  config,
  lib,
  ...
}: let
  cfg = config.garden.programs;
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
    };
  };
}
