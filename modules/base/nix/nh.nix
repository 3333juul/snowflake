{
  pkgs,
  config,
  ...
}: let
  inherit (config.garden.system) mainUser;
in {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/home/${mainUser}/snowflake";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
