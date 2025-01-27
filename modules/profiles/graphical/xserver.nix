{pkgs, ...}: {
  services = {
    xserver = {
      enable = false;
      xkb.layout = "pl,us";
      displayManager.startx.enable = false;
      excludePackages = [pkgs.xterm];
    };
  };
}
