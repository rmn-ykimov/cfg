# cfg

Nix flakes for macOS (nix-darwin), a NixOS desktop and NixOS-WSL, plus a
Neovim configuration based on kickstart.nvim.

## Layout

```text
.config/nvim/          Neovim config (lazy.nvim, one file per plugin in lua/plugins/)
nix/
  shared/
    inputs/flake.nix   inputs used by every host (nixpkgs, home-manager, ...)
    packages.nix       package list installed on every host
    programs/          Home Manager modules for every host: zsh, starship, broot, zoxide
  darwin/              macOS (nix-darwin + Home Manager + nix-homebrew)
    modules/system/    macOS defaults, nix-darwin settings, /Applications links
    modules/packages/  system packages and Homebrew casks
  nixos/               NixOS desktop (GNOME)
  wsl/                 NixOS-WSL
    hosts/wsl.nix      host settings, user, services
    hosts/certs.nix    extra root CA for system, Node, Python and the JDK
    hosts/nix-ld.nix   libraries for prebuilt Linux binaries
    hosts/postgresql.nix
```

Each host directory is its own flake with its own `flake.lock`.

## Apply

```shell
# macOS
cd ~/cfg/nix/darwin && darwin-rebuild switch --flake .

# NixOS desktop
cd ~/cfg/nix/nixos && sudo nixos-rebuild switch --flake .

# NixOS-WSL (reads a root CA kept outside the repo, hence --impure)
cd ~/cfg/nix/wsl && sudo nixos-rebuild switch --impure --flake .#nixos
```

The WSL host expects the CA at `/etc/nixos/extra-ca/root-ca.pem` (root-owned);
without it the build stops with a message saying so.

## Neovim

Link the config into `~/.config` with GNU Stow (`.stow-local-ignore` keeps
`nix/` and repo files out):

```shell
cd ~/cfg && stow -t ~ .
```

Plugins install on first start. Treesitter parsers are listed in
`lua/plugins/treesitter.lua`; add a language there to get highlighting for it.
