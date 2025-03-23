# Module Options

This folder contains **module options** designed to make the configuration
modular, allowing parts of the config to be enabled or disabled based on the
[host configuration](../../../hosts)

---

## Key Concepts

### Option types

#### `mkOption`

Defines a customizable option. It requires a `type` (e.g., `bool`, `str`,
`enum`) and can include a `default` value and a `description`.

Example:

```nix
options.garden.environment = {
  desktop = {
    type = mkOption {
      type = nullOr (enum [
        "Hyprland"
        "yabai"
        "sway"
        "cosmic"
      ]);
      default = "Hyprland";
      description = "The desktop environment to be used.";
    };
  };
```

#### `mkEnableOption`

A shorthand for creating a boolean option that is typically used to enable or
disable a module. It automatically sets the `type` to `bool` and provides a
default value of `false`.

Example:

```nix
options.garden.programs.cli.enable = mkEnableOption "enable CLI tools";
```

### Creating conditions based on the module options

The `mkIf` function is used to conditionally include or exclude configurations
based on the value of a module option.

Example:

```nix
{ config, lib, ... }: {

  config = lib.mkIf config.garden.programs.cli.enable {
    # Enable CLI tools only if the option is set to true
    programs.bash.enable = true;
    programs.zsh.enable = true;
  };
}
```

### Host configuration

Here’s how you might use these options in a host configuration:

```nix
{
  garden = {
    device = {
      type = "laptop";
      gpu = "nvidia";
      hasBluetooth = true;
    };

    programs = {
      cli = {
        enable = true;
        shell = "zsh";
      };
    };
  };
}
```
