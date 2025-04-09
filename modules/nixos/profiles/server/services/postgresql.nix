{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.helpers) addBackupPaths;

  cfg = config.garden.services;
  dataDir = "/var/lib/postgresql/${config.services.postgresql.package.psqlSchema}";
in {
  config = mkIf cfg.postgresql.enable {
    services = {
      postgresql = {
        enable = true;
        package = pkgs.postgresql_17;
        inherit dataDir;

        ensureDatabases = [
        ];

        ensureUsers = [
          {
            name = "postgres";
            ensureClauses = {
              superuser = true;
              login = true; # not implied by superuser
              createrole = true;
              createdb = true;
              replication = true;
            };
          }
        ];
      };

      restic.backups = addBackupPaths config ["*"] [dataDir];
    };
  };
}
