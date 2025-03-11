{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.services) rclone;

  mkMount = {
    remotePath,
    mountPoint,
    configFile,
    autostart ? false,
  }: {
    description = "Rclone mount";
    wantedBy = optionals autostart ["multi-user.target"];

    serviceConfig = {
      ExecStop = "${pkgs.fuse}/bin/fusermount -u ${mountPoint}";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mountPoint}";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
          ${remotePath} \
          ${mountPoint} \
          --config ${configFile} \
          --allow-other \
          --vfs-cache-mode full
      '';
      Restart = "on-failure";
      Type = "notify";
    };
  };
in {
  config = mkIf rclone.enable {
    systemd = {
      services = {
        rclone-onedrive-mount = mkMount {
          remotePath = "onedrive:";
          mountPoint = "/run/media/${mainUser}/rclone/onedrive";
          configFile = config.age.secrets.rclone.path;
        };
      };
    };

    environment.systemPackages = let
      tm = pkgs.writeShellScriptBin "tm" ''
        #!/bin/bash

        toggle_mount() {
          local service="$1"
          if systemctl is-active --quiet "$service"; then
            echo "Unmouting: $service"
            sudo systemctl stop "$service"
          else
            echo "Mounting: $service"
            sudo systemctl start "$service"
          fi
        }

        case "$1" in
          onedrive)
            toggle_mount "rclone-onedrive-mount"
            ;;
          *)
            echo "Usage: tm <mount-name>"
            echo "Supported mounts:"
            echo "1. onedrive"
            exit 1
            ;;
        esac
      '';
    in [pkgs.rclone tm];
  };
}
