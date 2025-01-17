{
  lib,
  config,
  ...
}: let
  inherit (config.garden.system) mainUser;

  cfg = config.garden.services;
in {
  services.syncthing = lib.mkIf cfg.syncthing.enable {
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
        "NoteAir3" = {
          id = "VUMQXRR-NBDKLJA-5F2EM56-ZWTQASA-VN5MLHZ-XJUNAFX-ZR5TRDM-LSNOEQV";
        };
      };
      folders = {
        "NoteAir3 - Books" = {
          path = "/home/${mainUser}/Documents/Syncthing/NoteAir3/Books";
          devices = ["NoteAir3"];
          id = "ttzrq-xytfk";
          versioning = {
            type = "simple";
            params = {
              keep = "10";
            };
          };
        };
        "NoteAir3 - Koreader" = {
          path = "/home/${mainUser}/Documents/Syncthing/NoteAir3/Koreader";
          devices = ["NoteAir3"];
          id = "09010-icymx";
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
}
