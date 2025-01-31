{
  garden = {
    system = {
      mainUser = "scay";

      boot = {
        loader = "systemd-boot";
      };

      video.enable = true;
      sound.enable = true;
      bluetooth.enable = true;
      printing.enable = false;

      loginManager = {
        name = "greetd";
        autoLogin.enable = false;
      };

      virtualization = {
        enable = true;
        docker.enable = false;
        qemu.enable = true;
        podman.enable = false;
        distrobox.enable = false;
      };
    };
  };
}
