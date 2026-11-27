{ pkgs, ... }:
# Packages installed on every host (one nixpkgs, nixos-unstable).
with pkgs;
[
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
  tldr

  ## Shells
  #nushell

  #gopass
  zoxide
  broot

  ffmpeg
  postgresql
  docker-compose
  # djvu2pdf was removed from nixpkgs (unmaintained); ddjvu -format=pdf does the same
  djvulibre
  #blender

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
  pyright

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
  temurin-bin-25
  (maven.override { jdk_headless = temurin-bin-25; })
  jdt-language-server
  lemminx # XML language server (pom.xml, testng.xml)
  # Run it on the same JDK 25 jdt-language-server uses instead of pulling
  # a separate ~0.9 GB JDK 21.
  (google-java-format.override { jre = jdk25; })

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
  #claude-code

  #anki-bin
  #zoom-us
  #dbeaver-bin
  #minikube
]
