{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./plugins
    ./mappings.nix
  ];

  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      type = "Application";
      mimeType = ["text/plain"];
      icon = "nvim";
      exec = "${pkgs.kitty}/bin/kitty nvim";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      leaderKey = " ";
      useSystemClipboard = true;
    };
  };
}
