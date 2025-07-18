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
    nodejs_24

    ## Development Tools
    tree-sitter
    uv
    scons
    cmake
    gnumake
    dotnetCorePackages.sdk_9_0-bin

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
    uutils-coreutils
    #uutils-findutils
    uutils-diffutils

    ## Network Tools
    curl
    wget
    inetutils

    # Shell and Terminal
    ## Shell
    zsh
    starship

    ## Terminal Multiplexer
    tmux

    ## Shell Utilities
    stow
    tldr

    gopass

    zoxide
    broot

    ffmpeg
    postgresql
    docker-compose
    djvu2pdf
    imagemagick

    anki-bin
    vscode
    blender
  ];
}
