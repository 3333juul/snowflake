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
      monitors = [];
      # hasTPM = "true"; # TODO
      hasBluetooth = true;
      hasSound = true;
      hasTouchscreen = false;
      keyboard = "pl";
    };

    system = {
      mainUser = "juul";

      boot = {
        loader = "systemd-boot";
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

      security.tor.enable = false;

      specialisations = {
        enable = false;
        hybrid.server.enable = false;
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
