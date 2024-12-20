# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget  
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    ffmpeg
          
    git
    git-lfs
          
    stow
    starship
    tmux
    rar
    ripgrep
    postgresql
          
    docker
    docker-compose
         
    python313
    python312
          
    djvu2pdf
         
    scons
    cmake
         
    vulkan-tools
          
    tree

    vscode
    google-chrome
    obsidian
    darktable
    dbeaver-bin
    zotero
    lmstudio
    wireguard-tools
    utm
  ];
}
