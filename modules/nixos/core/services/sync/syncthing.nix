{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.helpers) filterEnabled;
  inherit (config.garden.system) mainUser;
  inherit (config.networking) hostName;

  homeDir = config.users.users.${mainUser}.home;
  cfg = config.garden.services.syncthing;

  # add these devices if they're not the current host
  desktop = mkIf (hostName != "desktop") "desktop";
  # laptop = mkIf (hostName != "laptop") "laptop";
in {
  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      dataDir = homeDir;
      openDefaultPorts = true;
      configDir = "${homeDir}/.config/syncthing";
      user = mainUser;
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

        # only enable these folders that are defined in `garden.services.syncthing.folders`
        folders = filterEnabled cfg.folders {
          "s21/shared" = {
            path = "${homeDir}/syncthing/s21/shared";
            devices = ["s21"];
            id = "s21-shared";
            versioning = {
              type = "simple";
              params = {
                keep = "10";
              };
            };
          };

          "s21/downloads" = {
            path = "${homeDir}/syncthing/s21/downloads";
            devices = ["s21"];
            id = "s21-downloads";
            type = "receiveonly";
            versioning = {
              type = "simple";
              params = {
                keep = "10";
              };
            };
          };

          "s21/photoroom" = {
            path = "${homeDir}/syncthing/s21/photoroom";
            devices = ["s21"];
            id = "s21-photoroom";
            versioning = {
              type = "simple";
              params = {
                keep = "10";
              };
            };
          };

          "noteAir3/books" = {
            path = "${homeDir}/syncthing/note-air3/books";
            devices = ["noteAir3"];
            id = "noteair3-books";
            versioning = {
              type = "simple";
              params = {
                keep = "10";
              };
            };
          };

          "noteAir3/koreader" = {
            path = "${homeDir}/syncthing/note-air3/koreader";
            devices = ["noteAir3"];
            id = "noteair3-koreader";
            versioning = {
              type = "simple";
              params = {
                keep = "10";
              };
            };
          };

          "memes" = {
            path = "${homeDir}/syncthing/memes";
            devices = [desktop];
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

    # tray service
    systemd.user.services = mkIf cfg.tray.enable {
      syncthingtray = {
        description = "syncthing tray";
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.syncthingtray}/bin/syncthingtray --wait";
          Restart = "on-failure";
        };
        wantedBy = ["graphical-session.target"];
      };
    };
  };
}
