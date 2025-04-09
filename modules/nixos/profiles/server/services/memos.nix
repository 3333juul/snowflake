{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.helpers) addBackupPaths;

  user = "memos";
  group = "memos";
  port = 5230;
  dataDir = "/var/lib/memos";
  package = inputs.self.packages.${pkgs.system}.memos;
  cfg = config.garden.services.memos;
in {
  config = mkIf cfg.enable {
    systemd.services.memos = {
      description = "Memos, a privacy-first, lightweight note-taking solution.";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      environment = {
        MEMOS_PORT = toString port;
        MEMOS_MODE = "prod";
        MEMOS_DATA = dataDir;
      };

      serviceConfig = {
        Type = "simple";
        StateDirectory = "memos";
        User = user;
        Group = group;
        ExecStart = "${package}/bin/memos";
        Restart = "on-failure";

        ProtectHome = true;
        ProtectSystem = "strict";
        PrivateTmp = true;
        PrivateDevices = true;
        ProtectHostname = true;
        ProtectClock = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        NoNewPrivileges = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        RemoveIPC = true;
        PrivateMounts = true;
      };
    };

    users = {
      users.${user} = {
        isSystemUser = true;
        home = dataDir;
        inherit group;
      };

      groups.${group} = {};
    };

    services.restic.backups = addBackupPaths config ["*"] [dataDir];
  };
}
