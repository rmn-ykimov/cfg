{ pkgs, ... }:
{
  commonPackages = with pkgs; [
    # Development
    ## Editors and IDEs
    neovim

    ## Version Control
    git
    git-lfs

    ## Languages and Compilers
    gcc
    python313
    lua
    luajitPackages.luarocks
    zig
    nodejs_23

    ## Development Tools
    tree-sitter
    uv
    scons
    cmake

    # System Tools
    ## File Management
    tree
    unzip
    rar
    zip
    fd
    ripgrep

    ## System Monitoring
    htop
    coreutils

    ## Network Tools
    curl
    wget

    # Shell and Terminal
    ## Shell
    zsh
    starship

    ## Terminal Multiplexer
    tmux

    ## Shell Utilities
    stow
    tldr

    zoxide
    broot
  ];
}
