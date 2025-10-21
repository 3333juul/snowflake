# {osConfig, ...}:
# let
#   inherit (osConfig.age) secrets;
# in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    includes = [];

    matchBlocks = {
      "*" = {
        hashKnownHosts = true;
        compression = true;
      };

      "laptop" = {
        hostname = "192.168.12.44";
      };
    };
  };
}
