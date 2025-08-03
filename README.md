# cfg

Flakes for nix-darwin and nixos plus dotfiles.

---

## Project Structure

- `.zshrc` - zsh config
- `.config/nvim` - configuration for nvim
- `nixos/` - configurations for NixOS
- `nix-darwin/` - configurations for macOS
  - `modules/system/` - macOS system settings
    - `darwin-settings.nix` - basic nix-darwin settings (system version, compatibility)
    - `system-defaults.nix` - macOS preferences (dock, updates, mouse)
    - `applications-setup.nix` - integration of Nix applications into macOS (/Applications)
  - `nix-settings.nix` - Nix and nixpkgs configuration (experimental features, garbage collector, platform, unfree packages)
  - `modules/packages/` - package management
    - `system-packages.nix` - list of system packages to install via Nix
    - `homebrew.nix` - package management through Homebrew

---

## Applying Configurations

To activate a specific configuration, use:

```shell
# For WSL

cd ~/cfg/nix/wsl/
nixos-rebuild switch --flake .
```

```shell
# For Desktop

cd ~/cfg/nix/nixos/
nixos-rebuild switch --flake .
```

---

## macOS Configuration

For macOS, a separate configuration is used via nix-darwin. Apply it with the
following commands:

```shell
cd ~/cfg/nix/darwin/
darwin-rebuild switch --flake .
```

---

```shell
stow -t ~ .
