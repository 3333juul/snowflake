{
  hosts = {
    desktop = {
      class = "nixos";
      arch = "x86_64";
      profiles = [
        "desktop"
        "graphical"
      ];
    };

    laptop = {
      class = "nixos";
      arch = "x86_64";
      profiles = [
        "laptop"
        "graphical"
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
