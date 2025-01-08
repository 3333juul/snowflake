{
  pkgs,
  username,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "pl,us";
      displayManager.startx.enable = false;
    };

    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
    };
  };
}
