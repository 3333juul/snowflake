{inputs, username, host, ...}: {
  imports = [
    ./ags.nix                         # widgets
    ./aichat.nix                      # ai
    ./bat.nix                         # better cat command
    ./btop.nix                        # resouces monitor 
    ./cava.nix                        # audio visualizer
    ./discord/discord.nix             # discord with catppuccin theme
    ./fastfetch.nix                   # fetch tool
    ./floorp/floorp.nix               # firefox based browser
    ./brave.nix                       # brave browser
    ./fzf.nix                         # fuzzy finder
    ./gaming.nix                      # packages related to gaming
    ./git.nix                         # version control
    ./glance.nix                      # home page
    ./gnome.nix                       # gnome apps
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./kitty.nix                       # terminal
    ./foot.nix                        # terminal
    ./swaync/swaync.nix               # notification deamon
    ./nvf/nvf.nix                     # neovim config framework
    ./lazyvim/nvim.nix                # neovim editor
    ./packages.nix                    # other packages
    ./rofi/rofi.nix                   # launcher
    ./scripts                         # personal scripts
    ./spicetify.nix                   # spotify client
    ./starship.nix                    # shell prompt
    ./swayimg.nix                     # image viewer 
    ./tofi.nix                        # launcher
    ./yazi                            # file manager
    ./vscodium.nix                    # vscode forck
    ./waybar/waybar.nix               # status bar
    ./xdg-mimes.nix                   # xdg config
    ./zsh.nix                         # shell

    # Unused
    #./aseprite/aseprite.nix           # pixel art editor
    #./audacious.nix                   # music player
    #./swaylock.nix                    # lock screen
    #./micro.nix                       # nano replacement
    #./retroarch.nix  

  ];
}
