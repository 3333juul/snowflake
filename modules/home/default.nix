{
  inputs,
  username,
  host,
  ...
}: {
  imports = [
    #./ags.nix # widgets
    ./aichat.nix # ai
    ./bat.nix # better cat command
    ./btop.nix # resouces monitor
    ./browser # browsers
    #./cava.nix                        # audio visualizer
    ./discord/discord.nix # discord with catppuccin theme
    ./fastfetch.nix # fetch tool
    ./fzf.nix # fuzzy finder
    ./gaming.nix # packages related to gaming
    ./git.nix # version control
    ./glance.nix # home page
    ./gnome.nix # gnome apps
    ./hyprland # window manager
    ./kitty.nix # terminal
    ./foot.nix # terminal
    ./swaync/swaync.nix # notification deamon
    ./nvf/nvf.nix # neovim config framework
    ./packages.nix # other packages
    ./pqiv.nix # image viwer
    ./rofi/rofi.nix # launcher
    ./scripts # personal scripts
    ./shell # shell
    ./spotify/spicetify.nix # spotify client
    ./starship.nix # shell prompt
    ./swayimg.nix # image viewer
    ./theme # gtk/qt/font/cursor
    ./thumbnailers.nix # thumbnailers
    ./thunar.nix # file manager
    ./tofi.nix # launcher
    ./yazi # file manager
    ./vscodium.nix # vscode forck
    ./waybar/waybar.nix # status bar
    ./xdg-mimes.nix # xdg config

    # Unused
    #./aseprite/aseprite.nix           # pixel art editor
    #./audacious.nix                   # music player
    #./swaylock.nix                    # lock screen
    #./micro.nix                       # nano replacement
    #./retroarch.nix
    #./lazyvim/nvim.nix                # neovim editor
  ];
}
