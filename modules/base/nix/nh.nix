{config, ...}: let
  inherit (config.garden.environment) flakePath;
in {
  programs.nh = {
    enable = true;
    flake = flakePath;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
  };
}
