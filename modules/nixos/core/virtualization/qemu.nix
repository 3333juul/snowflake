{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf;
  inherit (config.garden.system) mainUser;

  sys = config.garden.system;
  cfg = sys.virtualization;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = optionals cfg.qemu.enable [
      pkgs.virt-manager
      pkgs.virt-viewer
      pkgs.quickemu
      pkgs.quickgui
    ];

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
  };
}
