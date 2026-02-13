{ pkgs, pkgs-unstable ? pkgs, ... }:
{
  stablePackages = with pkgs; [
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

    ## Shells
    nushell

    #gopass
    zoxide
    broot

    ffmpeg
    postgresql
    #docker-compose
    djvu2pdf
    imagemagick
    #blender
  ];

  unstablePackages = with pkgs-unstable; [
    # Development
    ## Editors and IDEs
    neovim
    vscode

    ## Version Control
    git
    git-lfs

    ## Languages and Compilers
    gcc

    markdownlint-cli

    python314
    ruff

    lua
    luajitPackages.luarocks
    stylua
    lua-language-server
    
    zig
    
    nodejs_24

    jdt-language-server
    google-java-format
    
    rustc
    cargo

    ## Development Tools
    tree-sitter
    uv
    scons
    cmake
    gnumake
    dotnetCorePackages.sdk_9_0-bin
    jdk21_headless

    #anki-bin
    #zoom-us

    dbeaver-bin
  ];
}
