{lib, ...}: let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkForce;
in {
  # the docs create issues that are really hard to debug
  # such as ones where lib does not get passed correctly
  manual = mapAttrs (_: mkForce) {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };
}
