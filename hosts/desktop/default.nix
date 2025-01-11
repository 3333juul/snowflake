{...}: {
  imports = [
    ./hardware-configuration.nix

    ../../modules/base
    ../../modules/nixos

    ../../modules/profiles/desktop
    ../../modules/profiles/graphical
  ];

  garden = {
    device = {
      type = "desktop";
      cpu = "amd";
      gpu = "amd";
      monitors = ["DVI-D-1" "HDMI-A-1"];
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
      virtualization.enable = true;

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
        cava.enable = true;
      };

      gui = {
        enable = true;
        anki.enable = true;
        calibre.enable = true;
        gimp.enable = true;
        pinta.enable = true;
        mpv.enable = true;
        thunar.enable = true;
        zotero.enable = true;
        brave.enable = true;
        rofi.enable = true;
        tofi.enable = true;
        vscodium.enable = true;
        discord.enable = true;
        libreoffice.enable = true;
        image = {
          vimiv.enable = true;
        };
        terminal = {
          kitty.enable = true;
        };
      };

      gaming = {
        enable = true;
        steam.enable = true;
        lutris.enable = true;
      };
    };

    services = {
      syncthing.enable = true;
      glance.enable = true;
    };
  };
}
