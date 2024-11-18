{inputs, ...}: {
  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "kvantum";
    };
  };

  xdg.configFile = {
    "Kvantum/Gruvbox-Dark-Blue".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox-Dark-Blue";
    "Kvantum/Gruvbox-Dark-Brown".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox-Dark-Brown";
    "Kvantum/Gruvbox-Dark-Green".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox-Dark-Green";
    "Kvantum/Gruvbox_Light_Blue".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox_Light_Blue";
    "Kvantum/Gruvbox_Light_Brown".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox_Light_Brown";
    "Kvantum/Gruvbox_Light_Green".source = "${inputs.gruvbox-kvantum-themes}/Gruvbox_Light_Green";

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Gruvbox-Dark-Brown
    '';
  };

  # xdg.configFile = {
  #   "Kvantum/gruvbox-kvantum/".source = "${inputs.gruvbox-kvantum}/gruvbox-kvantum/";
  #   "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=gruvbox-kvantum";
  # };
}
