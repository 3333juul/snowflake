{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.services) rclone;

  mkMount = {
    mountPoint,
    configFile,
    remote,
  }: {
    description = "Rclone mount for ${remote}";
    # wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStop = "${pkgs.fuse}/bin/fusermount -u ${mountPoint}";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${mountPoint}";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount \
          ${remote}: \
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
          mountPoint = "/home/${mainUser}/mounts/rclone/onedrive";
          configFile = config.age.secrets.rclone.path;
          remote = "onedrive";
        };
      };
    };

    environment.systemPackages = [pkgs.rclone];

    environment.shellAliases = {
      mount-onedrive = "sudo systemctl start rclone-onedrive-mount";
      unmount-onedrive = "sudo systemctl stop rclone-onedrive-mount";
    };
  };
}
