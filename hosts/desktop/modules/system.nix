{
  garden = {
    system = {
      mainUser = "scay";

      video.enable = true;
      sound.enable = true;
      bluetooth.enable = true;
      printing.enable = false;

      boot = {
        loader = "systemd-boot";
      };

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
