{inputs, ...}: let
  inherit (inputs.self) lib;
  inherit (lib.builders) mkHostConfig;

  profilesPath = ../modules/profiles;

  desktop = profilesPath + /desktop;
  laptop = profilesPath + /laptop;
  server = profilesPath + /server;
  graphical = profilesPath + /graphical;
  headless = profilesPath + /headless;
in {
  flake = {
    nixosConfigurations = {
      desktop = mkHostConfig {
        host = "desktop";
        class = "nixos";
        arch = "x86_64";
        profiles = [
          desktop
          graphical
        ];
      };

      laptop = mkHostConfig {
        host = "laptop";
        class = "nixos";
        arch = "x86_64";
        profiles = [
          laptop
          graphical
        ];
      };

      server = mkHostConfig {
        host = "server";
        class = "nixos";
        arch = "x86_64";
        profiles = [
          server
          headless
        ];
      };
    };
  };
}
