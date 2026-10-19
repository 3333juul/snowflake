{
  imports = [
    ./hardware.nix
    ./hub.nix
  ];

  garden = {
    device = {
      type = "server";
      cpu = null;
      gpu = null;
      monitors = [];
      hasTPM = false;
      hasBluetooth = false;
      hasSound = false;
      hasTouchscreen = false;
    };

    system = {
      mainUser = "juul";

      
      enableSecrets = true;

      boot.loader = "systemd-boot";

      fs.support = [
        "ext4"
        "vfat"
      ];

      video.enable = false;
      sound.enable = false;
      bluetooth.enable = false;
      printing.enable = false;

      loginManager.name = "none";

      specialisations.enable = false;

      networking = {
        wirelessBackend = "wpa_supplicant";

        tailscale = {
          enable = false;
          isServer = false;
          isClient = false;
        };
      };

      virtualization = {
        enable = false;
        docker.enable = false;
        qemu.enable = false;
        podman.enable = false;
        distrobox.enable = false;
      };

      android = {
        enable = false;
        scrcpy.enable = false;
      };
    };
  };
}

