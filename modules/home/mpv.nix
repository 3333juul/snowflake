{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    package = pkgs.mpv;
    bindings = {
    };
    config = {
      keep-open = "yes";
      save-position-on-quit = "yes";
    };
  };
}
