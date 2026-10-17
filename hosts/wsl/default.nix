{
  imports = [
    ./hub.nix
  ];

  garden = {
    device = {
      type = "wsl";
      cpu = null;
      gpu = null;
      monitors = [];
      hasTPM = false;
      hasBluetooth = false;
      hasSound = false;
      hasTouchscreen = false;
      keyboard = "pl";
    };

    system = {
      mainUser = "juul";

      boot = {
        loader = "none";
      };

      fs.support = [
        "ext4"
        "vfat"
        "ntfs"
      ];

      video.enable = false;
      sound.enable = false;
      bluetooth.enable = false;
      printing.enable = false;

      loginManager = {
        name = "none";
        autoLogin.enable = false;
      };

      security.tor.enable = false;

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

      android = {
        enable = false;
        scrcpy.enable = false;
      };
    };
  };
}
