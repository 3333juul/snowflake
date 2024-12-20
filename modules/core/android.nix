{
  pkgs,
  username,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (symlinkJoin {
      name = "scrcpy-wrapped";
      paths = [pkgs.scrcpy];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/scrcpy \
          --set SDL_VIDEODRIVER wayland \
          --add-flags "--turn-screen-off --stay-awake" \
          --add-flags "--power-off-on-close" \
          --add-flags "--display-buffer=200 --audio-buffer=200 --audio-output-buffer=20"
      '';
    })
    android-tools
  ];

  programs.adb.enable = true;
  users.users.${username}.extraGroups = ["adbusers"];
}
