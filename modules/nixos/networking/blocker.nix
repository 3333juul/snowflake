{config, ...}: let
  inherit (config.garden) device;
in {
  networking.stevenblack = {
    enable = device.type != "server";
    block = [
      "gambling"
      "porn"
      # "social"
    ];
  };
}
