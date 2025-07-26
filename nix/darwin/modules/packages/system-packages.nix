# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget  
{ pkgs, pkgs-unstable, ... }:

let
  shared = import ../../../shared/packages.nix { inherit pkgs pkgs-unstable; };
in
{
  environment.systemPackages = 
    shared.stablePackages ++
    shared.unstablePackages ++
    (with pkgs; [
      # macOS specific
      mkalias
      
      # GUI applications
      google-chrome
      obsidian
      zotero
    ]);
}
