# Home Manager settings for every host; each host's home.nix adds its own.
{
  lib,
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/broot.nix
    ./programs/zoxide.nix
  ];

  home.username = username;
  home.homeDirectory = lib.mkForce (
    if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${username}" else "/home/${username}"
  );
  home.packages = import ./packages.nix { inherit pkgs; };

  programs.home-manager.enable = true;
}
