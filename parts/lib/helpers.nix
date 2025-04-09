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
