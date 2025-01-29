{ pkgs, ... }:
{
  commonPackages = with pkgs; [
    # Development tools
    neovim
    git
    gcc
    tree-sitter
    lua
    python313

    # System utilities
    tree
    unzip
    rar
    ripgrep
    tmux
    stow

    # Shell
    starship
  ];
}
