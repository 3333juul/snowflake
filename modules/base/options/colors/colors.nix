{
  lib,
  config,
  ...
}: let
  inherit (lib.types) str;
  inherit (lib) mkOption;

  # Funkcja do ładowania schematów kolorów
  loadColorScheme = name: import (./colors + "/" + name + ".nix");

  # Lista dostępnych schematów kolorów
  availableSchemes = ["catppuccin-frappe" "nord"];
in {
  options.colorscheme = mkOption {
    type = str;
    default = "catppuccin-frappe";
    example = "nord";
    description = ''
      The name of the color scheme to use. Available options: ${lib.concatStringsSep ", " availableSchemes}.
    '';
  };

  config.garden.style.colors = loadColorScheme config.colorscheme;
}
