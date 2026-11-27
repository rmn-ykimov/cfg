# Home Manager settings for every host; each host's home.nix adds its own.
{
  config,
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

  # ~/.config/nvim points at the live folder in the repo (expects it at ~/cfg),
  # so nvim config edits apply without a rebuild.
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/cfg/.config/nvim";

  programs.home-manager.enable = true;
}
