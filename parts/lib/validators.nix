{lib, ...}: let
  inherit (lib.trivial) flip;
  inherit (builtins) elem any;

  /*
  *
  convenience function check if the declared device type is of an accepted type

  # Arguments

  - [config] the configuration that nixosConfigurations provides
  - [list] a list of devices that will be accepted

  # Type

  ```
  hasProfile :: AttrSet -> List -> Bool
  ```

  # Example

  ```nix
  hasProfile osConfig ["foo" "bar"]
  => false
  ```
  */
  hasProfile = conf: list: any (flip elem conf.garden.device.profiles) list;
in {
  inherit
    hasProfile
    ;
}
