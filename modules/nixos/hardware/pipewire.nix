{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.garden) device;
  cfg = config.garden.system.sound;
in {
  services.pipewire = mkIf (cfg.enable && device.hasSound) {
    enable = true;

    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}
