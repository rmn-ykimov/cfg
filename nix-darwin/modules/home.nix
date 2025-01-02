{ config, pkgs, ... }:

{
  home.stateVersion = "23.11";
  
  home.username = "roman";
  home.homeDirectory = pkgs.lib.mkForce "/Users/roman";
  
  # Базовые пакеты
  home.packages = with pkgs; [
  ];

  programs.home-manager.enable = true;
}
