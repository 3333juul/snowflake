{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  # a headless system should not mount any removable media
  # without explicit user action
  services.udisks2.enable = mkForce false;
}
