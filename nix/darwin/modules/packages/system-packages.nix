# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget  
{ pkgs, ... }:

let
  shared = import ../../../shared/packages.nix { inherit pkgs; };
in
{
  environment.systemPackages = 
    shared.commonPackages ++
    (with pkgs; [
      # macOS specific
      mkalias
      
      # Additional tools
      ffmpeg
      postgresql
      docker-compose
      djvu2pdf

      # GUI applications
      vscode
      google-chrome
      obsidian
      zotero
      wireguard-tools
      blockbench
    ]);
}
