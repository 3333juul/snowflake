{
  config,
  pkgs,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        FastConnectable = true;
      };
      Policy = {
        ReconnectAttempts = 7;
        ReconnectIntervals = "1,2,3,4,8";
        AutoEnable = true;
      };
    };
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    bluez-tools
  ];
}
