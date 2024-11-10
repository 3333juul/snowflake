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

  programs.nvf = {
    enable = true;
    settings.vim = {
      viAlias = true;
      leaderKey = " ";
      useSystemClipboard = true;
    };
  };
}
