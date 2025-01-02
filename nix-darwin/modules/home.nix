{ config, pkgs, ... }:

{
  
  home = {
    stateVersion = "25.05";
    username = "roman";
    homeDirectory = pkgs.lib.mkForce "/Users/roman";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
