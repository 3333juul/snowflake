{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.garden.programs;
in {
  programs = {
    # needed to interact with gtk
    dconf.enable = true;
  };
}
