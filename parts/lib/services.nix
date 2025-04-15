{lib, ...}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.attrsets) mapAttrs' nameValuePair;
  inherit (lib.modules) mkMerge;
  inherit (lib.types) str;

  # generate systemd services for each enabled backup defined in `services.restic.backups`.
  # if a backup fails, a desktop notification will be sent, displaying the last 5 lines of the backup log from the journal.
  # inspo: https://www.arthurkoziel.com/restic-backups-b2-nixos/
  mkResticNotify = pkgs: {
    backups,
    user,
  }: let
    # create a notification service for a given backup
    mkNotifyService = name:
      nameValuePair "notify-backup-failed-${name}" {
        enable = true;
        description = "Notify on failed backup for ${name}";
        serviceConfig = {
          Type = "oneshot";
          User = user;
        };

        # required for notify-send to work
        environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";

        script = ''
          ${pkgs.libnotify}/bin/notify-send --urgency=critical \
            "Backup failed for ${name}" \
            "$(journalctl -u restic-backups-${name} -n 5 -o cat)"
        '';
      };

    # link a backup service to its notification service
    mkOnFailureLink = name:
      nameValuePair "restic-backups-${name}" {
        unitConfig.OnFailure = "notify-backup-failed-${name}.service";
      };
  in
    mkMerge [
      (mapAttrs' (name: _: mkNotifyService name) backups)
      (mapAttrs' (name: _: mkOnFailureLink name) backups)
    ];

  /*
  *
  A quick way to use my services abstraction

  # Arguments

  - [name]: The name of the service

  # Type

  ```
  mkServiceOption :: String -> (Int -> String -> String -> AttrSet) -> AttrSet
  ```
  */
  mkServiceOption = name: {
    port ? 0,
    host ? "127.0.0.1",
    domain ? "",
    extraConfig ? {},
  }:
    {
      enable = mkEnableOption "Enable the ${name} service";

      host = mkOption {
        type = str;
        default = host;
        description = "The host for ${name} service";
      };

      port = mkOption {
        type = lib.types.port;
        default = port;
        description = "The port for ${name} service";
      };

      domain = mkOption {
        type = str;
        default = domain;
        description = "Domain name for the ${name} service";
      };
    }
    // extraConfig;
in {
  inherit mkResticNotify mkServiceOption;
}
