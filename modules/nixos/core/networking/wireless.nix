{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;

  inherit (config.garden.system.networking) wirelessBackend;
in {
  config = {
    # enable wireless database, it helps keeping wifi speedy
    hardware.wirelessRegulatoryDatabase = true;

    networking.wireless = {
      # wpa_supplicant
      enable = wirelessBackend == "wpa_supplicant";
      userControlled.enable = true;
      allowAuxiliaryImperativeNetworks = true;

      extraConfig = ''
        update_config=1
      '';

      # iwd
      iwd = {
        enable = wirelessBackend == "iwd";

        settings = {
          Settings.AutoConnect = true;

          General = {
            # AddressRandomization = "network";
            # AddressRandomizationRange = "full";
            EnableNetworkConfiguration = true;
            RoamRetryInterval = 15;
          };

          Network = {
            EnableIPv6 = true;
            RoutePriorityOffset = 300;
          };
        };
      };
    };
  };
}
