{lib, ...}: let
  inherit (lib.builders) mkHostConfig;

  profilesPath = ../modules/profiles;

  desktop = profilesPath + /desktop;
  laptop = profilesPath + /laptop;
  server = profilesPath + /server;
  graphical = profilesPath + /graphical;
  headless = profilesPath + /headless;
in {
  nixosConfigurations = {
    desktop = mkHostConfig {
      host = "desktop";
      profiles = [
        desktop
        graphical
      ];
    };

    laptop = mkHostConfig {
      host = "laptop";
      profiles = [
        laptop
        graphical
      ];
    };

    server = mkHostConfig {
      host = "server";
      profiles = [
        server
        headless
      ];
    };
  };
}
