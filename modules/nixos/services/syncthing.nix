{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (builtins) elem filter;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.services) syncthing;
  inherit (syncthing) enabledDevices;
  inherit (syncthing) enabledFolders;

  ifEnabled = filter (device: elem device enabledDevices);
in {
  services.syncthing = mkIf syncthing.enable {
    enable = true;
    dataDir = "/home/${mainUser}";
    openDefaultPorts = true;
    configDir = "/home/${mainUser}/.config/syncthing";
    user = "${mainUser}";
    group = "users";
    guiAddress = "0.0.0.0:8384";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "desktop" = mkIf (elem "desktop" enabledDevices) {
          id = "DQKQIC3-HGHTTVZ-5HTLAYD-XVI36WW-RD7W3NK-PWVZ2AR-LRV5AAV-2DJBQQR";
        };

        "laptop" = mkIf (elem "laptop" enabledDevices) {
          id = "";
        };

        "s21" = mkIf (elem "s21" enabledDevices) {
          id = "AH33REO-A7DKTJ2-WOW2PMV-RBMYWOY-7APMQ7H-F6OHHVW-QNPUAUB-KJTQLAK";
        };

        "noteAir3" = mkIf (elem "noteAir3" enabledDevices) {
          id = "VUMQXRR-NBDKLJA-5F2EM56-ZWTQASA-VN5MLHZ-XJUNAFX-ZR5TRDM-LSNOEQV";
        };
      };

      folders = {
        "noteAir3/books" = mkIf (elem "noteAir3" enabledDevices) {
          path = "/home/${mainUser}/documents/syncthing/noteAir3/books";
          devices = ["noteAir3"];
          id = "ttzrq-xytfk";
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };

        "noteAir3/koreader" = mkIf (elem "noteAir3" enabledDevices) {
          path = "/home/${mainUser}/documents/syncthing/noteAir3/koreader";
          devices = ["noteAir3"];
          id = "09010-icymx";
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };

        "memes" = mkIf (elem "memes" enabledFolders) {
          path = "/home/${mainUser}/documents/syncthing/memes";
          devices = ifEnabled ["s21" "laptop" "desktop"];
          id = "memes-folder";
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };
      };
    };
  };

  # don't create default ~/Sync folder
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}
