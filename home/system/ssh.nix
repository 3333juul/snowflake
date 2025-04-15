# {osConfig, ...}:
# let
#   inherit (osConfig.age) secrets;
# in
{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    compression = true;

    includes = [
    ];

    matchBlocks = {
      "laptop".hostname = "192.168.12.44";
    };
  };
}
