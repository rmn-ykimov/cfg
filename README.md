# nix-config
Personal nix config for nix-darwin and nixos.

---

## Project Structure

- `nixos/` - configurations for NixOS
- `nix-darwin/` - configurations for macOS

---

## Applying Configurations

To activate a specific configuration, use:

```shell
# For WSL
nixos-rebuild switch --flake .#nixos-wsl
```

```shell
# For Desktop
nixos-rebuild switch --flake .#nixos-desktop
```

---

## macOS Configuration

For macOS, a separate configuration is used via nix-darwin. Apply it with the following command:

```shell
darwin-rebuild build --flake .#Romans-MacBook-Air
```
