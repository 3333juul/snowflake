{osConfig, ...}: let
  inherit (osConfig.age) secrets;
in {
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    compression = true;

    includes = [
    ];

    matchBlocks = {
    };
  };
}
