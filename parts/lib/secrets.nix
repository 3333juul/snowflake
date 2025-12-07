{inputs}: let
  inherit (inputs) self;

  /*
  *
  Create secrets for use with `agenix`.

  # Arguments

  - [file] the age file to use for the secret
  - [owner] the owner of the secret, this defaults to "root"
  - [group] the group of the secret, this defaults to "root"
  - [mode] the permissions of the secret, this defaults to "400"

  # Type

  ```
  mkSecret :: (String -> String -> String -> String) -> AttrSet
  ```

  # Example

  ```nix
  mkSecret { file = "./my-secret.age"; }
  => {
    file = "./my-secret.age";
    owner = "root";
    group = "root";
    mode = "400";
  }
  ```
  */
  mkSecret = {
    file,
    owner ? "root",
    group ? "root",
    mode ? "400",
    ...
  }: {
    file = "${self}/secrets/${file}.age";
    inherit owner group mode;
  };

  /*
  *
  A light wrapper around mkSecret that allows you to specify the output path

  # Arguments

  - [file] the age file to use for the secret
  - [owner] the owner of the secret, this defaults to "root"
  - [group] the group of the secret, this defaults to "root"
  - [mode] the permissions of the secret, this defaults to "400"
  - [path] the path to output the secret to
  - [symlink] if "false", the secret will be copied instead of symlinked. this defaults to "true"

  # Type

  ```
  mkSecretWithPath :: (String -> String -> String -> String -> String -> Bool) -> AttrSet
  ```

  # Example

  ```nix
  mkSecret { file = "./my-secret.age"; path = "/etc/my-secret"; }
  => {
    file = "./my-secret.age";
    path = "/etc/my-secret";
    owner = "root";
    group = "root";
    mode = "400";
    symlink = true;
  }
  ```
  */
  mkSecretWithPath = {
    file,
    path,
    owner ? "root",
    group ? "root",
    mode ? "400",
    symlink ? true,
    ...
  }:
    mkSecret {
      inherit
        file
        owner
        group
        mode
        ;
    }
    // {
      inherit path symlink;
    };

  # TODO: description
  mkSecretHM = {
    file,
    path,
    symlink ? true,
    ...
  }: {
    file = "${self}/secrets/${file}.age";
    inherit path symlink;
  };
in {
  inherit mkSecret mkSecretWithPath mkSecretHM;
}
