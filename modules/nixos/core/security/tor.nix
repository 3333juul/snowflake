{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.garden.system.security.tor;
in {
  services.tor = mkIf cfg.enable {
    enable = true;
    client.enable = true;
    client.dns.enable = true;
    torsocks.enable = true;
  };
}
