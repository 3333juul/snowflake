{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        25565
      ];
      allowedUDPPorts = [
      ];
    };
  };
}
