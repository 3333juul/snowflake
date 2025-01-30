{
  imports = [
    ./hardware.nix
    ./programs.nix
    ./services.nix
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

    environment = {
      desktop = {
        type = "Hyprland";
        hyprland = {
          useFlake = false;
        };
      };
      useHomeManager = true;
    };

    system = {
      mainUser = "scay";

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

      virtualization = {
        enable = true;
        docker.enable = false;
        qemu.enable = true;
        podman.enable = false;
        distrobox.enable = false;
      };
    };
  };
}
