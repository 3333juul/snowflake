{
  imports = [
    ./hardware.nix
    ./programs.nix
    ./services.nix
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
      keyboard = "pl";
    };

    environment = {
      shell = "zsh";
      useHomeManager = true;

      desktop = {
        type = "Hyprland";
        hyprland = {
          useFlake = true;
        };
      };
    };

    system = {
      mainUser = "scay";

      video.enable = true;
      sound.enable = true;
      bluetooth.enable = true;
      printing.enable = false;

      boot = {
        loader = "systemd-boot";
      };

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
