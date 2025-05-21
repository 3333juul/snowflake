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
        useHomeManager = true;
        useHjem = true;
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
    };

    server = {
      class = "nixos";
      arch = "x86_64";
      profiles = [
        "server"
        "headless"
      ];
    };

    darwin = {
      class = "darwin";
      arch = "x86_64";
    };
  };
}
