{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.lists) optionals;
  inherit (config.garden.system) mainUser;

  cfg = config.garden.system.android;

  phone = with cfg.phone;
    pkgs.writeShellScriptBin "phone" ''
      adb connect "${ip}:${builtins.toString port}"
      scrcpy --stay-awake --turn-screen-off --power-off-on-close
    '';
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [android-tools]
      ++ optionals cfg.scrcpy.enable
      [scrcpy phone];

    programs.adb.enable = true;
    users.users.${mainUser}.extraGroups = ["adbusers"];
  };
}
# https://github.com/Genymobile/scrcpy/blob/master/doc/connection.md

