{...}: {
  imports = [
    #./ags # widgets
    ./browser # browsers
    ./discord/discord.nix # discord
    ./hyprland # wm
    ./image-viewer # image viewer applications
    ./rofi/rofi.nix # app launcher
    ./spotify/spicetify.nix # music
    ./swaync/swaync.nix # notification manager
    ./terminal # terminals
    ./waybar/waybar.nix # status bar
    ./gaming.nix # gaming
    ./gnome.nix
    ./mpv.nix # media player
    ./thunar.nix # file manager
    ./tofi.nix # app launcher
    ./vscodium.nix # VSCodium editor
  ];
}

