# Module Options

This folder contains **module options** that define customizable settings for
system configurations. These options are designed to make the configuration
**modular**, meaning they can be enabled, disabled, or customized in
[host configurations](../../hosts) to create flexible and reusable setups.

---

## Key Concepts

### `mkOption`

Defines a customizable option. It requires a `type` (e.g., `bool`, `str`,
`listOf`) and can include a `default` value and a `description`.

Example:

```nix
options.garden.device.type = mkOption {
  type = types.enum ["laptop" "desktop" "server"];
  default = "laptop";
  description = "The type of device.";
};
```

### `mkEnableOption`

A shorthand for creating a boolean option that is typically used to enable or
disable a module. It automatically sets the `type` to `bool` and provides a
default value of `false`.

Example:

```nix
options.garden.programs.cli.enable = mkEnableOption "enable CLI tools";
```

### Using module options in the config

The mkIf function is used to conditionally include or exclude configurations
based on the value of a module option.

Example:

```nix
{ config, lib, ... }: {
  options.garden.programs.cli.enable = lib.mkEnableOption "enable CLI tools";

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
