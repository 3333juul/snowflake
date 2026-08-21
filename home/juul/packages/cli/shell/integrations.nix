# this file is used to enable or disable shell intergrations based on the shell itself
{osConfig, ...}: let
  inherit (osConfig.garden.environment) shell;
in {
  home.shell = {
    # disable the global enable
    enableShellIntegration = false;

    enableZshIntegration = shell == "zsh";
    enableBashIntegration = shell == "bash";
    enableFishIntegration = shell == "fish";
    enableNushellIntegration = shell == "nushell";
    enableIonIntegration = shell == "ion";
  };
}
