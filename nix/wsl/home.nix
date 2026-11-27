{
  pkgs,
  username,
  nix-index-database,
  ...
}: let
  shared = import ../shared/packages.nix { inherit pkgs; };
  
  unstable-packages = with pkgs.unstable; [
  ];

  stable-packages = with pkgs; [
  ];
  
in {
  imports = [
    nix-index-database.homeModules.nix-index
    ../shared/programs/starship.nix
    ../shared/programs/zsh.nix
    ../shared/programs/broot.nix
    ../shared/programs/zoxide.nix
  ];

  home.stateVersion = "26.05";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/zsh";

    # Hermes installer puts its launcher here; ~/.zshrc is read-only
    # (managed by Home Manager), so the installer cannot add it itself.
    sessionPath = [ "$HOME/.local/bin" ];
  };

  home.packages =
    stable-packages
    ++ unstable-packages
    ++ shared.stablePackages
    ++ shared.unstablePackages;

  programs = {

    home-manager.enable = true;

    # Claude subscription token for Hermes / Hindsight / gbrain on this box
    # (file is mode 600, created by hand, never in the repo or Nix store).
    zsh.envExtra = ''
      if [ -r "$HOME/.config/claude/oauth-token.env" ]; then
        set -a; . "$HOME/.config/claude/oauth-token.env"; set +a
      fi
    '';
    
    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    nix-index-database.comma.enable = true;

    # FIXME: disable whatever you don't want
    fzf.enable = true;
    fzf.enableZshIntegration = true;

    #lsd.enable = true;
    #lsd.enableAliases = true;

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    # git = {
    #   enable = true;
    #   package = pkgs.unstable.git;
    #   delta.enable = true;
    #   delta.options = {
    #     line-numbers = true;
    #     side-by-side = true;
    #     navigate = true;
    #   };
    #   userEmail = ""; # FIXME: set your git email
    #   userName = ""; #FIXME: set your git username
    #   extraConfig = {
    #     # FIXME: uncomment the next lines if you want to be able to clone private https repos
    #     # url = {
    #     #   "https://oauth2:${secrets.github_token}@github.com" = {
    #     #     insteadOf = "https://github.com";
    #     #   };
    #     #   "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
    #     #     insteadOf = "https://gitlab.com";
    #     #   };
    #     # };
    #     push = {
    #       default = "current";
    #       autoSetupRemote = true;
    #     };
    #     merge = {
    #       conflictstyle = "diff3";
    #     };
    #     diff = {
    #       colorMoved = "default";
    #     };
        #   };
        # };
  };
}
