{lib, ...}: let
  inherit (lib.modules) mkMerge;
  inherit (lib.attrsets) mapAttrs' nameValuePair;

  mkResticNotify = pkgs: {
    backups,
    user,
  }: let
    mkNotifyService = name:
      nameValuePair "notify-backup-failed-${name}" {
        enable = true;
        description = "Notify on failed backup for ${name}";
        serviceConfig = {
          Type = "oneshot";
          User = user;
        };

        environment.DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";

        script = ''
          ${pkgs.libnotify}/bin/notify-send --urgency=critical \
            "Backup failed for ${name}" \
            "$(journalctl -u restic-backups-${name} -n 5 -o cat)"
        '';
      };

    mkOnFailureLink = name:
      nameValuePair "restic-backups-${name}" {
        unitConfig.OnFailure = "notify-backup-failed-${name}.service";
      };
  in
    mkMerge [
      (mapAttrs' (name: _: mkNotifyService name) backups)
      (mapAttrs' (name: _: mkOnFailureLink name) backups)
    ];
in {
  inherit mkResticNotify;
}
