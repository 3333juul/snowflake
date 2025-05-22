{
  hosts = {
    desktop = {
      class = "nixos";
      arch = "x86_64";
      profiles = [
        "desktop"
        "graphical"
      ];

      extraModules = {
        homeManager.enable = true;
        hjem.enable = true;
      };
    };

    laptop = {
      class = "nixos";
      arch = "x86_64";
      profiles = [
        "laptop"
        "graphical"
        "server"
      ];

      extraModules = {
        homeManager.enable = true;
      };
    };

    server = {
      class = "nixos";
      arch = "x86_64";
      profiles = [
        "server"
        "headless"
      ];

      extraModules = {
        homeManager.enable = true;
      };
    };

    darwin = {
      class = "darwin";
      arch = "x86_64";
    };
  };
}
