{
  osConfig,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;

  cfg = osConfig.garden.programs.astal;
in {
  config = mkIf cfg.enable (
    let
      packageName = "astal";

      package = inputs.ags.lib.bundle {
        inherit pkgs;
        src = ./ags-config;
        name = packageName;
        entry = "app.ts";
        extraPackages = [
          inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.battery
          inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.bluetooth
          inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
          inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}.network
        ];
      };
    in {
      home.packages = with pkgs; [
        adwaita-icon-theme
      ];

      systemd.user.services.astal = {
        Unit = {
          Description = "Astal";
          Documentation = "https://github.com/Aylur/astal";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session-pre.target"];
        };

        Service = {
          ExecStart = "${package}/bin/${packageName}";
          Restart = "on-failure";
          KillMode = "mixed";
        };

        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };
    }
  );
}
