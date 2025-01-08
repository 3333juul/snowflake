{...}: {
  imports = [
    ./hardware-configuration.nix

    ./../../modules/base
    ./../../modules/nixos

    ./../../modules/profiles/desktop
    ./../../modules/profiles/graphical
  ];

  garden = {
    desktop = "Hyprland";

    system = {
      virtualization.enable = true;
    };

    programs = {
      cli = {
        enable = true;
        shell = "zsh";
        git.enable = true;
        bat.enable = true;
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
        obs.enable = true;
        brave.enable = true;
        rofi.enable = true;
        tofi.enable = true;
        vscodium.enable = true;
        discord.enable = true;
        image = {
          vimiv.enable = true;
        };
        terminal = {
          kitty.enable = true;
        };
      };

      gaming = {
        steam.enable = true;
      };
    };

    services = {
      syncthing.enable = true;
      glance.enable = true;
    };
  };
}
