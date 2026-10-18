{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.self.packages.${pkgs.stdenv.hostPlatform.system}) somewm;
in {
  home.packages = [
    somewm
  ];
}
