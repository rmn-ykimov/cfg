{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";
  
  home.username = "roman";
  home.homeDirectory = pkgs.lib.mkForce "/Users/roman";
  
  home.packages = with pkgs; [
  ];

  programs.home-manager.enable = true;
}
