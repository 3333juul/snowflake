{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sdcv
  ];
}
