{
  imports = [
    ./hub.nix
    ./hardware.nix
  ];

  garden = {
    device = {
      type = "laptop";
      cpu = "intel";
      gpu = "intel";
      # hasTPM = "true"; # TODO
      hasBluetooth = true;
      hasSound = true;
      keyboard = "pl";
    };

    system = {
      mainUser = "juul";

      boot = {
        loader = "systemd-boot";
      };

      video.enable = true;
      sound.enable = true;
      bluetooth.enable = true;
      printing.enable = false;

      loginManager = {
        name = "greetd";
        autoLogin.enable = false;
      };

      fs.support = [
        "ext4"
        "vfat"
        "ntfs"
      ];

      networking = {
        wirelessBackend = "iwd";

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
    };
  };
}
