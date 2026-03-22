{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.self.packages.${pkgs.system}) somewm;
in {
  home.packages = [
    somewm
  ];
}
