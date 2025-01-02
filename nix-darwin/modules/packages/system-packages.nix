# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget  
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    mkalias
    ffmpeg
    tree
    unzip
    gcc
    tree-sitter

    # Version control      
    git
    git-lfs
          
    stow
    starship
    tmux
    rar
    ripgrep
    postgresql
          
    # Docker
    docker-compose
         
    # Python     
    python313
    python312
    uv
          
    djvu2pdf
    
    # Build tools
    scons
    cmake
         
    #vulkan-tools
          
    vscode
    google-chrome
    obsidian
    #darktable
    #dbeaver-bin
    zotero
    #lmstudio
    wireguard-tools
    #utm
    #blockbench
  ];
}
