{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [hyprpaper];
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };
}
