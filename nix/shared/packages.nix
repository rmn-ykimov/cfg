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
    #blender
  ];

  unstablePackages = with pkgs-unstable; [

    pkg-config
    imagemagick

    # Development
    
    ## Editors and IDEs
    neovim
    #vscode

    ## Version Control
    git
    git-lfs

    ## Languages and Compilers
    gcc

    markdownlint-cli

    ### Python
    python314
    ruff

    ### Lua
    luajit
    luajitPackages.luarocks
    stylua
    lua-language-server
    
    ### Zig
    zig
    
    ### NodeJS
    nodejs_24

    ### Java
    jdk21_headless
    jdt-language-server
    google-java-format
    
    ### Rust
    rustc
    cargo

    ### Nix
    nixfmt
    nixd

    ## Development Tools
    tree-sitter
    uv
    scons
    cmake
    gnumake
    dotnetCorePackages.sdk_9_0-bin

    #anki-bin
    #zoom-us

    dbeaver-bin
  ];
}
