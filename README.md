# cfg

Nix configuration for three hosts in one flake: macOS (nix-darwin), a NixOS
desktop and NixOS-WSL, plus a Neovim configuration based on kickstart.nvim.

## Layout

```text
flake.nix              inputs and the three hosts: wsl, desktop, mac
flake.lock             one lock for all hosts
.config/nvim/          Neovim config (lazy.nvim, one file per plugin in lua/plugins/)
nix/
  shared/
    nix.nix            Nix settings for every host (flakes, store optimisation, gc)
    home.nix           Home Manager base for every host: programs, packages
    packages.nix       package list installed on every host
    programs/          zsh, starship, broot, zoxide
  darwin/              macOS (nix-darwin + Home Manager + nix-homebrew)
    default.nix        host entry point
    modules/system/    macOS defaults, nix-darwin settings, /Applications links
    modules/packages/  macOS packages and Homebrew casks
  nixos/               NixOS desktop (GNOME)
  wsl/                 NixOS-WSL
    hosts/wsl.nix      host settings, user, services
    hosts/certs.nix    extra root CA for system, Node, Python and the JDK
    hosts/nix-ld.nix   libraries for prebuilt Linux binaries
    hosts/postgresql.nix
```

## Apply

```shell
# macOS
darwin-rebuild switch --flake ~/cfg#mac

# NixOS desktop
sudo nixos-rebuild switch --flake ~/cfg#desktop

# NixOS-WSL (reads a root CA kept outside the repo, hence --impure)
sudo nixos-rebuild switch --impure --flake ~/cfg#wsl
```

The WSL host expects the CA at `/etc/nixos/extra-ca/root-ca.pem` (root-owned);
without it the build stops with a message saying so.

## Update

`nix flake update` in `~/cfg` moves every host to the same new versions;
then switch each host. `nix fmt` formats every `.nix` file.

## Neovim

Home Manager links `~/.config/nvim` to `~/cfg/.config/nvim` on switch, so the
repo must live at `~/cfg`; edits to the nvim config apply without a rebuild.

Plugins install on first start. Treesitter parsers are listed in
`lua/plugins/treesitter.lua`; add a language there to get highlighting for it.
