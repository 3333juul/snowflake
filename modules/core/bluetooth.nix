{
  config,
  pkgs,
  ...
}: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    bluez-tools
  ];
}
