{
  pkgs,
  username,
  nix-index-database,
  ...
}: let
  unstable-packages = with pkgs.unstable; [
    coreutils
    curl
    git
    htop
    ripgrep
    tmux
    tree
    rar
    vim
    wget
    zip
    neovim
    nerd-fonts.jetbrains-mono
  ];

  stable-packages = with pkgs; [
    # FIXME: customize these stable packages to your liking for the languages
    # that you use
    
    # Shell
    zsh

  ];
  
in {
  imports = [
    nix-index-database.hmModules.nix-index
  ];

  home.stateVersion = "24.05";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables.EDITOR = "nvim";
    # FIXME: set your preferred $SHELL
    sessionVariables.SHELL = "/etc/profiles/per-user/${username}/bin/zsh";
  };

  home.packages =
    stable-packages
    ++ unstable-packages
    ++
    # FIXME: you can add anything else that doesn't fit into the above two lists in here
    [
      # pkgs.some-package
      # pkgs.unstable.some-other-package
    ];

  programs = {

    home-manager.enable = true;
    
    nix-index.enable = true;
    nix-index.enableZshIntegration = true;
    nix-index-database.comma.enable = true;

    starship.enable = true; # https://gist.github.com/s-a-c/0e44dc7766922308924812d4c019b109#file-starship-nix
    starship.settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      kubernetes.disabled = false;
      git_branch.style = "242";
      directory.style = "blue";
      directory.truncate_to_repo = false;
      directory.truncation_length = 8;
      python.disabled = false;
      ruby.disabled = true;
      hostname.ssh_only = false;
      hostname.style = "bold green";

    };

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

    zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
    };

    git = {
      enable = true;
      package = pkgs.unstable.git;
      delta.enable = true;
      delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
      userEmail = ""; # FIXME: set your git email
      userName = ""; #FIXME: set your git username
      extraConfig = {
        # FIXME: uncomment the next lines if you want to be able to clone private https repos
        # url = {
        #   "https://oauth2:${secrets.github_token}@github.com" = {
        #     insteadOf = "https://github.com";
        #   };
        #   "https://oauth2:${secrets.gitlab_token}@gitlab.com" = {
        #     insteadOf = "https://gitlab.com";
        #   };
        # };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        merge = {
          conflictstyle = "diff3";
        };
        diff = {
          colorMoved = "default";
        };
      };
    };
  };
}
