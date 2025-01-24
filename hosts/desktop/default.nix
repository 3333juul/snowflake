{
  imports = [./hardware-configuration.nix];

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
      desktop = {
        type = "Hyprland";
        hyprland = {
          useFlake = true;
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
      virtualization.enable = true;
      printing.enable = false;

      loginManager = {
        name = "greetd";
        autoLogin.enable = false;
      };
    };

    programs = {
      cli = {
        enable = true;
        shell = "zsh";
        androidTools.enable = true;
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
        spotify.enable = true;
        tofi.enable = true;
        vscodium.enable = true;
        discord.enable = true;
        libreoffice.enable = true;
        imageViewer = {
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
        minecraft.enable = true;
      };
    };

    services = {
      syncthing.enable = true;
      glance.enable = true;
      kdeconnect = {
        enable = true;
        indicator.enable = true;
      };
    };
  };
}
