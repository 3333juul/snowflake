{
  # this configuration creates the shell aliases across: bash, zsh and fish
  home.shellAliases = {
    # utils
    c = "clear";
    cd = "z";
    tt = "gtrash put";
    cat = "bat";
    nano = "micro";
    code = "codium";
    py = "python";
    icat = "kitten icat";
    dsize = "du -hs";
    pdf = "tdf";
    open = "xdg-open";
    space = "ncdu";
    man = "BAT_THEME='default' batman";

    l = "eza --icons  -a --group-directories-first -1"; #EZA_ICON_SPACING=2
    ll = "eza --icons  -a --group-directories-first -1 --no-user --long";
    tree = "eza --icons --tree --group-directories-first";

    # nixos
    cdnix = "cd ~/snowflake && codium ~/snowflake";
    ns = "nom-shell --run zsh";
    nix-switch = "nh os switch";
    nix-update = "nh os switch --update";
    nix-clean = "nh clean all --keep 5";
    nix-search = "nh search";
    nix-test = "nh os test";

    # python
    piv = "python -m venv .venv";
    psv = "source .venv/bin/activate";

    # hyprland
    hl = "Hyprland";
    clients = "hyprctl -j clients | jless";
    monitors = "hyprctl -j monitors | jless";
  };
}
