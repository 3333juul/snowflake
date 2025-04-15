{
  imports = [
    ./hub.nix
    ./hardware.nix
  ];

  garden = {
    device = {
      type = "desktop";
      cpu = "amd";
      gpu = "amd";
      monitors = ["HDMI-A-1" "DVI-D-1"];
      hasTPM = true;
      hasBluetooth = true;
      hasSound = true;
      hasTouchscreen = false;
      keyboard = "pl";
    };

    system = {
      mainUser = "scay"; # TODO: change it after reinstalling the system

      boot = {
        loader = "grub";
      };

      fs.support = [
        "ext4"
        "vfat"
        "ntfs"
      ];

      video.enable = true;
      sound.enable = true;
      bluetooth.enable = true;
      printing.enable = false;

      loginManager = {
        name = "greetd";
        autoLogin.enable = false;
      };

      specialisations = {
        enable = true;
        steamOS.enable = true;
      };

      networking = {
        wirelessBackend = "iwd";

        tailscale = {
          enable = false;
          isServer = false;
          isClient = false;
        };
      };

      virtualization = {
        enable = true;
        docker.enable = false;
        qemu.enable = true;
        podman.enable = false;
        distrobox.enable = false;
      };

      android = {
        enable = true;
        scrcpy.enable = true;
      };
    };
  };
}
