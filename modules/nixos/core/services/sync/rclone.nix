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
  # mkMountRestic = {
  #   repo,
  #   mountPoint,
  #   passwordFile,
  #   configFile,
  #   autostart ? false,
  # }: {
  #   description = "Restic snapshot mount";
  #   wantedBy = optionals autostart ["multi-user.target"];
  #
  #   serviceConfig = {
  #     ExecStop = "${pkgs.fuse3}/bin/fusermount3 -u ${mountPoint}";
  #     # FIXME: find way to add fusermount to path
  #     ExecStartPre = ''
  #       export PATH=$PATH:${lib.makeBinPath [pkgs.fuse3]}
  #       ${pkgs.coreutils}/bin/mkdir -p ${mountPoint}
  #       ${pkgs.coreutils}/bin/chown ${mainUser} ${mountPoint}
  #     '';
  #
  #     ExecStart = ''
  #       ${pkgs.restic}/bin/restic -r ${repo} \
  #         mount ${mountPoint}
  #     '';
  #     Environment = [
  #       "RESTIC_PASSWORD_FILE=${passwordFile}"
  #       "RCLONE_CONFIG=${configFile}"
  #       "XDG_CACHE_HOME=/home/${mainUser}/.cache"
  #     ];
  #
  #     Restart = "on-failure";
  #     Type = "simple";
  #   };
  # };
in {
  config = mkIf cfg.enable {
    systemd = {
      services = {
        rclone-onedrive-mount = mkMountRclone {
          remotePath = "onedrive:";
          mountPoint = "/run/media/${mainUser}/rclone/onedrive";
          configFile = config.age.secrets.rclone.path;
        };

        # restic-onedrive-mount = mkMountRestic {
        #   repo = "rclone:onedrive:Restic/desktop";
        #   mountPoint = "/run/media/${mainUser}/restic";
        #   passwordFile = config.age.secrets.restic-password.path;
        #   configFile = config.age.secrets.rclone.path;
        # };
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
          # restic-onedrive)
          #   toggle_mount "restic-onedrive-mount"
          #   ;;
          *)
            echo "Usage: tm <mount-name>"
            echo "Supported mounts:"
            echo "1. rclone-onedrive"
            # echo "2. restic-onedrive"
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
