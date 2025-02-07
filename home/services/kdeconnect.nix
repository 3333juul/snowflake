{
  lib,
  osConfig,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.services.kdeconnect;
in {
  config = mkIf cfg.enable {
    services.kdeconnect = {
      enable = true;
      indicator = cfg.indicator.enable;
    };

    # TODO: causes long start of brave-browser, find better way to disable kwallet
    home.file.".config/kwalletrc".text = ''
      [Wallet]
      First Use=false
      Enabled=false
    '';
  };
}
