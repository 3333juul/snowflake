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
      monitors = ["DP-2" "DP-3"];
      hasTPM = true;
      hasBluetooth = true;
      hasSound = true;
      hasTouchscreen = false;
      keyboard = "pl";
    };

    system = {
      mainUser = "juul";

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

      security.tor.enable = false;

      specialisations = {
        enable = false;
        steamOS.enable = false;
      };

      networking = {
        wirelessBackend = "iwd";

        tailscale = {
          enable = false;
          isServer = false;
          isClient = true;
        };
      };

      virtualization = {
        enable = false;
        docker.enable = false;
        qemu.enable = true;
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
