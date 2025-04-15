{pkgs, ...}: {
  systemd.services.rsshub = {
    wantedBy = ["multi-user.target"];
    script = ''
      ${pkgs.rsshub}/bin/rsshub
    '';

    environment = {
      # NO_LOGFILES = "true";
      PORT = "1300";
    };

    serviceConfig = {
      Restart = "on-failure";
    };
  };
}
