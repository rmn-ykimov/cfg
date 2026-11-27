{
  pkgs,
  username,
  nix-index-database,
  ...
}:
{
  imports = [
    nix-index-database.homeModules.nix-index
    ../shared/programs/zsh.nix
    ../shared/programs/starship.nix
    ../shared/programs/broot.nix
    ../shared/programs/zoxide.nix
  ];

  home = {
    stateVersion = "26.05";
    inherit username;
    homeDirectory = "/home/${username}";
    sessionVariables.EDITOR = "nvim";
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/zsh";
    # The Hermes installer puts its launcher here and cannot edit ~/.zshrc.
    sessionPath = [ "$HOME/.local/bin" ];
  };

  home.packages = import ../shared/packages.nix { inherit pkgs; };

  programs = {
    home-manager.enable = true;

    # Claude token for Hermes, Hindsight and gbrain (mode-600 file, not in git).
    zsh.envExtra = ''
      if [ -r "$HOME/.config/claude/oauth-token.env" ]; then
        set -a; . "$HOME/.config/claude/oauth-token.env"; set +a
      fi
    '';

    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    fzf.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };
}
