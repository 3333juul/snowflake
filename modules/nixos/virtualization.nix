{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.lists) optionals concatLists;
  inherit (lib.modules) mkIf mkMerge;
  inherit (config.garden.system) mainUser;

  sys = config.garden.system;
  cfg = sys.virtualization;
in {
  config = mkIf cfg.enable (mkMerge [
    {
      environment.systemPackages = concatLists [
        (optionals cfg.qemu.enable [
          pkgs.virt-manager
          pkgs.virt-viewer
        ])

        (optionals cfg.docker.enable [
          pkgs.podman
          pkgs.podman-compose
        ])

        (optionals (cfg.docker.enable && sys.video.enable) [pkgs.lxd-lts])

        (optionals cfg.distrobox.enable [pkgs.distrobox])

        (optionals cfg.waydroid.enable [pkgs.waydroid])
      ];
    }

    {
      virtualisation = {
        kvmgt.enable = true;
        spiceUSBRedirection.enable = true;

        waydroid.enable = cfg.waydroid.enable;
        lxd.enable = cfg.waydroid.enable;
      };
    }

    (mkIf cfg.qemu.enable {
      virtualisation.libvirtd = {
        enable = true;

        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };
        };
      };
      # Add user to libvirtd group
      users.users.${mainUser}.extraGroups = ["libvirtd"];
    })

    (mkIf (cfg.docker.enable || cfg.podman.enable) {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
        enableNvidia = builtins.any (driver: driver == "nvidia") config.services.xserver.videoDrivers;
        autoPrune = {
          enable = true;
          flags = ["--all"];
          dates = "weekly";
        };
      };
    })

    (mkIf cfg.distrobox.enable {
      systemd.user = {
        timers."distrobox-update" = {
          enable = true;
          wantedBy = ["timers.target"];
          timerConfig = {
            OnBootSec = "1h";
            OnUnitActiveSec = "1d";
            Unit = "distrobox-update.service";
          };
        };

        services."distrobox-update" = {
          enable = true;
          script = ''
            ${getExe pkgs.distrobox} upgrade --all
          '';
          serviceConfig = {
            Type = "oneshot";
          };
        };
      };
    })
  ]);
}
