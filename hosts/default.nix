{
  hosts = {
    desktop.profiles = [
      "desktop"
      "graphical"
    ];

    laptop.profiles = [
      "laptop"
      "graphical"
    ];

    server.profiles = [
      "server"
      "headless"
    ];

    darwin = {
      class = "darwin";
      arch = "x86_64";
    };
  };
}
