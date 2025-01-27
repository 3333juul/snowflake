# Module Options

This folder contains **module options** that define customizable settings for
system configurations. These options are designed to make the config
**modular**, meaning they can be enabled, disabled, or customized in
[host configurations](hosts) to create flexible and reusable setups.

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
