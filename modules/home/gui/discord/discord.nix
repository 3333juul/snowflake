{pkgs, ...}: {
  home.packages = with pkgs; [
    # discord
    (discord.override {
      withVencord = true;
    })
    vesktop
  ];
  xdg.configFile."Vencord/themes/gruvbox.theme.css".source = ./gruvbox.css;
}
