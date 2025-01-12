{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
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

  services = {
    # thermald.enable = true;
    # cpupower-gui.enable = true;
    power-profiles-daemon.enable = true;

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "PowerOff";
    };

    # auto-cpufreq = {
    #   enable = true;
    #   settings = {
    #     battery = {
    #       governor = "performance";
    #       turbo = "auto";
    #     };
    #     charger = {
    #       governor = "performance";
    #       turbo = "auto";
    #     };
    #   };
    # };
  };

  powerManagement.cpuFreqGovernor = "performance";

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
      type = "desktop";
      cpu = "amd";
      gpu = "amd";
      # hasTPM = "true"; # TODO
      hasBluetooth = true;
      hasSound = true;
      keyboard = "pl";
    };

    environment = {
      desktop = "Hyprland";
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
