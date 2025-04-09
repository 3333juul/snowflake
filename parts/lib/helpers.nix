{lib}: let
  inherit (lib.attrsets) filterAttrs;

  /*
  *
  filters elements based on a list of enabled keys.

  # Arguments

  - [keys] the list of enabled keys
  - [attrs] the attribute set to filter

  # Type

  ```
  filterEnabled :: List -> AttrSet -> AttrSet
  ```

  # Example

  ```nix
  filterEnabled ["key1" "key2"] {
    key1 = { ... };
    key2 = { ... };
    key3 = { ... };
  }
  => {
    key1 = { ... };
    key2 = { ... };
  }
  ```
  */
  filterEnabled = keys: attrs: filterAttrs (name: _: builtins.elem name keys) attrs;

  /*
  *
  convenient helper for adding paths to multiple backups.

  # Arguments

  - [config] the configuration that nixosConfigurations provides
  - [backups]: list of backups to select, or `["*"]` to select all enabled backups
  - [paths]: list of paths to add to each selected backup

  # Type

  ```
  addBackupPaths :: AttrSet -> [String] -> [Path] -> AttrSet
  ```

  # Example

  ```nix
  services.restic.backups = addBackupPaths config ["backup1" "backup2"] [
    "/path/1"
    "/path/2"
  ]
  => {
    backup1 = { paths = ["/path/1" "/path/2"]; };
    backup2 = { paths = ["/path/1" "/path/2"]; };
  };
  ```
  */

  addBackupPaths = config: backups: paths: let
    names =
      if builtins.elem "*" backups
      then config.garden.services.restic.backups
      else backups;
  in
    builtins.listToAttrs (map (name: {
        inherit name;
        value = {inherit paths;};
      })
      names);
in {
  inherit
    filterEnabled
    addBackupPaths
    ;
}
