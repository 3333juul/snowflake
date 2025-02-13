{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = config.garden.services;
in {
  conifg = mkIf cfg.restic.enable {
    # agenix
    # TODO:

    # ssh known hosts
    programs.ssh.knownHosts = {
    };

    # TODO:
    services.restic.backups = {
      remotebackup = {
        initialize = true;
        paths = [
          # what to backup
        ];
        passwordFile = ""; # encryption
        repository = "";

        extraOptions = [
          # how to connect
        ];
        timerConfig = {
          # when to backup
          OnCalendar = "00:05";
          RandomizedDelaySec = "5h";
        };
      };
    };
  };
}
