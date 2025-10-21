{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.environment) shell useHomeManager;

  xdgConfig = config.home-manager.users.${mainUser}.xdg;
in {
  # https://github.com/nix-community/home-manager/issues/1965#issuecomment-2075045184
  config = mkIf (shell == "zsh" && useHomeManager) {
    environment.etc."zshenv".text = ''
      source ${xdgConfig.configHome}/zsh/.zshenv
    '';

    hm = {
      home.file.".zshenv".enable = false;
      programs.zsh = {
        dotDir = "${xdgConfig.configHome}/zsh";
        history.path = "${xdgConfig.stateHome}/zsh/history";
      };
    };
  };
}
