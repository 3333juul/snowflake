{
  pkgs,
  config,
  ...
}: let
  inherit (config.garden.environment) flakePath;
in {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = flakePath;
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
