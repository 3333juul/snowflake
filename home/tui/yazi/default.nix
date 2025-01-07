{...}: {
  imports = [
    ./yazi.nix
    ./keymap.nix
    ./theme.nix
  ];

  xdg.configFile."yazi/plugins" = {
    source = ./plugins;
    recursive = true;
  };
}
