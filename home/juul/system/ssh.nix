# {osConfig, ...}:
# let
#   inherit (osConfig.age) secrets;
# in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    includes = [];

    settings = {
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
