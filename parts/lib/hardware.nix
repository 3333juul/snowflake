let
  /*
  *
  check if the host platform is linux and x86

  # Arguments

  - [pkgs] the package set

  # Type

  ```
  isx86Linux :: AttrSet -> Bool
  ```

  # Example

  ```nix
  isx86Linux pkgs
  => true
  ```
  */
  isx86Linux = pkgs: pkgs.stdenv.hostPlatform.isLinux && pkgs.stdenv.hostPlatform.isx86;

  /*
  *
  ldTernary, short for linux darwin ternary

  # Inputs

  - [pkgs] is the package set
  - [l] the value to return if the host platform is linux
  - [d] the value to return if the host platform is darwin

  # Type

  ```
  ldTernary :: AttrSet -> Any -> Any -> Any
  ```

  # Example

  ```nix
  ldTernary pkgs "linux" "darwin"
  => "linux"
  ```
  */
  ldTernary = pkgs: l: d:
    if pkgs.stdenv.hostPlatform.isLinux
    then l
    else if pkgs.stdenv.hostPlatform.isDarwin
    then d
    else throw "Unsupported system: ${pkgs.stdenv.system}";

  /*
  *
  assume the first monitor in the list of monitors is primary
  get its name from the list of monitors

  # Arguments

  - [config] the configuration that nixosConfigurations provides

  # Type

  ```
  primaryMonitor :: AttrSet -> String
  ```

  # Example

  ```nix
  primaryMonitor osConfig
  => "DP-1"
  ```
  */
  primaryMonitor = config: builtins.elemAt config.garden.device.monitors 0;

  /*
  *
  Get the monitor at the specified index from the list of monitors.
  If the index is out of bounds, return `null`.

  # Arguments

  - [index] The index of the monitor to retrieve (0-based).
  - [config] The configuration that nixosConfigurations provides.

  # Type

  ```
  monitor :: Int -> AttrSet -> String | Null
  ```

  # Example

  ```nix
  monitor 1 osConfig
  => "DP-1"

  monitor 2 osConfig
  => null
  ```
  */
  monitor = index: config:
    if builtins.length config.garden.device.monitors > index
    then builtins.elemAt config.garden.device.monitors index
    else null;
in {
  inherit isx86Linux ldTernary primaryMonitor monitor;
}
