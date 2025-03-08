{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.attrsets) mapAttrs;
  inherit (config.garden.system) mainUser;
  inherit (config.garden.services) syncthing;
  inherit (config.networking) hostName;
  inherit (builtins) elem;

  # add these devices only if they're not the current host
  desktop = mkIf (hostName != "desktop") "desktop";
  # laptop = mkIf (hostName != "laptop") "laptop";

  # only enable these folders that are defined in garden.services.syncthing.folders
  enabledFolders = mapAttrs (name: value: mkIf (elem name syncthing.folders) value);
in {
  config = mkIf syncthing.enable {
    services.syncthing = {
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
          "desktop" = mkIf (hostName != "desktop") {
            id = "DQKQIC3-HGHTTVZ-5HTLAYD-XVI36WW-RD7W3NK-PWVZ2AR-LRV5AAV-2DJBQQR";
          };

          # "laptop" = mkIf (hostName != "laptop") {
          #   id = "";
          # };

          "s21" = {
            id = "AH33REO-A7DKTJ2-WOW2PMV-RBMYWOY-7APMQ7H-F6OHHVW-QNPUAUB-KJTQLAK";
          };

          "noteAir3" = {
            id = "VUMQXRR-NBDKLJA-5F2EM56-ZWTQASA-VN5MLHZ-XJUNAFX-ZR5TRDM-LSNOEQV";
          };
        };

        folders = enabledFolders {
          "noteAir3/books" = {
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

          "noteAir3/koreader" = {
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

          "memes" = {
            path = "/home/${mainUser}/documents/syncthing/memes";
            devices = [desktop];
            id = "memes-folder";
            versioning = {
              type = "simple";
              params = {
                keep = "10";
              };
            };
          };

          "s21/shared" = {
            path = "/home/${mainUser}/documents/syncthing/s21/shared";
            devices = ["s21"];
            id = "phone-shared";
            versioning = {
              type = "simple";
              params = {
                keep = "10";
              };
            };
          };

          "s21/downloads" = {
            path = "/home/${mainUser}/documents/syncthing/s21/downloads";
            devices = ["s21"];
            id = "phone-downloads";
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
  };
}
