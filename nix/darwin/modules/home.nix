{ config, pkgs, ... }:

{

  imports = [
    ../../shared/programs/zsh.nix
    ../../shared/programs/starship.nix
  ];
  
  home = {
    stateVersion = "25.05";
    username = "roman";
    homeDirectory = pkgs.lib.mkForce "/Users/roman";
  };

  programs.home-manager.enable = true;
}
