{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.garden.system) mainUser;

  cfg = config.garden.programs.cli.androidTools;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (symlinkJoin {
        name = "scrcpy-wrapped";
        paths = [pkgs.scrcpy];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/scrcpy \
            --set SDL_VIDEODRIVER wayland \
            --add-flags "--turn-screen-off --stay-awake" \
            --add-flags "--power-off-on-close" \
        '';
      })
      android-tools
    ];

    programs.adb.enable = true;
    users.users.${mainUser}.extraGroups = ["adbusers"];
  };
}
