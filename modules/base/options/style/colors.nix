{
  lib,
  config,
  ...
}: let
  inherit (lib.types) str attrsOf;
  inherit (lib.options) mkOption;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.strings) removePrefix;

  loadColorScheme = name: import ./colorschemes/${name}.nix;

  # Remove "#" from each color value
  transformColorScheme = colors: mapAttrs (_name: color: removePrefix "#" color) colors;
in {
  options.garden.style = {
    colorScheme = mkOption {
      type = str;
      default = "gruvbox";
      description = "The name of the color scheme to use.";
    };

    colors = mkOption {
      type = attrsOf str;
      default = transformColorScheme (loadColorScheme config.garden.style.colorScheme);
      description = "The currently loaded color scheme.";
    };
  };
}
