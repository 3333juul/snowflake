{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;

  user = "memos";
  group = "memos";
  dataDir = "/var/lib/memos";
  package = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.memos;
  cfg = config.garden.services.memos;
in {
  config = mkIf cfg.enable {
    systemd.services.memos = {
      description = "Memos, a privacy-first, lightweight note-taking solution.";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];

      environment = {
        MEMOS_PORT = toString cfg.port;
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

    garden.services.restic.extraPaths = [dataDir];
  };
}
