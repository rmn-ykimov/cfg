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
    nix-index-database.hmModules.nix-index
    ../shared/programs/starship.nix
    ../shared/programs/zsh.nix
  ];

  home.stateVersion = "24.05";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/zsh";
  };

  home.packages =
    stable-packages
    ++ unstable-packages
    ++ shared.commonPackages;

  programs = {

    home-manager.enable = true;
    
    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    nix-index-database.comma.enable = true;

    # FIXME: disable whatever you don't want
    fzf.enable = true;
    fzf.enableZshIntegration = true;

    lsd.enable = true;
    lsd.enableAliases = true;

    zoxide.enable = true;
    zoxide.enableZshIntegration = true;
    zoxide.options = ["--cmd cd"];

    broot.enable = true;
    broot.enableZshIntegration = true;

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
