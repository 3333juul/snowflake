{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;
  inherit (config.garden.system) mainUser;

  cfg = config.garden.services.rclone;
  homeDir = config.users.users.${mainUser}.home;

  mkMountRclone = {
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
  config = mkIf cfg.enable {
    systemd = {
      services = {
        rclone-onedrive-mount = mkMountRclone {
          remotePath = "onedrive:";
          mountPoint = "/run/media/${mainUser}/rclone/onedrive";
          configFile = "${homeDir}/.config/rclone/rclone.conf";
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
          rclone-onedrive)
            toggle_mount "rclone-onedrive-mount"
            ;;
          *)
            echo "Usage: tm <mount-name>"
            echo "Supported mounts:"
            echo "1. rclone-onedrive"
            exit 1
            ;;
        esac
      '';
    in [
      tm
      pkgs.rclone
    ];
  };
}
