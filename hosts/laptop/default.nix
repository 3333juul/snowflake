{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/base
    ../../modules/nixos

    ../../modules/profiles/laptop
    ../../modules/profiles/graphical
  ];

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    cpupower-gui
    powertop
  ];

  #services = {
  # thermald.enable = true;
  # cpupower-gui.enable = true;
  #power-profiles-daemon.enable = true;
  #};

  #powerManagement.cpuFreqGovernor = "performance";

  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
  };

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
    };

    system = {
      mainUser = "scay";

      boot = {
        loader = "systemd-boot";
      };

      video.enable = true;
      sound.enable = true;
      bluetooth.enable = true;
      virtualization.enable = false;
      printing.enable = false;

      loginManager = {
        name = "greetd";
        autoLogin.enable = true;
      };
    };

    programs = {
      cli = {
        enable = true;
        shell = "zsh";
        git.enable = true;
        starship.enable = true;
      };

      tui = {
        enable = true;
        nvim.enable = true;
        yazi.enable = true;
        fzf.enable = true;
        btop.enable = true;
        lazygit.enable = true;
      };

      gui = {
        enable = true;
        thunar.enable = true;
        image = {
          vimiv.enable = true;
        };
        terminal = {
          kitty.enable = true;
        };
      };

      gaming = {
        enable = false;
      };
    };

    services = {
      syncthing.enable = false;
    };
  };
}
