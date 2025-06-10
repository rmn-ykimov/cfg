{ config, pkgs, ... }:

{
  imports = [
    ../shared/programs/zsh.nix
    ../shared/programs/starship.nix
    ../shared/programs/broot.nix
    ../shared/programs/zoxide.nix
  ];
  
  home = {
    stateVersion = "25.05";
    username = "roman";
    homeDirectory = "/home/roman";
  };

  # Добавляем shared пакеты
  home.packages = (import ../shared/packages.nix { inherit pkgs; }).commonPackages;

  programs.home-manager.enable = true;
}