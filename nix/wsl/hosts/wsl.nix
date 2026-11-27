{
  username,
  hostname,
  pkgs,
  inputs,
  ...
}: {
  
  time.timeZone = "Europe/Budapest";

  networking.hostName = "${hostname}";

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];

  # enableAllTerminfo pulls termite, whose old vte is not cached and fails to build
  # on this nixpkgs rev; Windows Terminal works with the default xterm terminfo.
  # environment.enableAllTerminfo = true;

  # sudo asks for the user's password; no SSH server inside WSL.
  # Set the password once from Windows: wsl -d NixOS -u root passwd <user>
  security.sudo.wheelNeedsPassword = true;

  # WSL has no real console; since 26.11 getty@tty1 gets started on switch
  # and fails (start-limit-hit), which turns every switch red.
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  imports = [
    ./certs.nix
    ./nix-ld.nix
    ./postgresql.nix
  ];

  # Local embeddings for gbrain (nomic-embed-text). Port 11435, not the
  # default 11434: gbrain's MCP wrapper (~/.gbrain/serve-mcp.sh) points here.
  services.ollama = {
    enable = true;
    host = "127.0.0.1";
    port = 11435;
    loadModels = [ "nomic-embed-text" ];
  };

  # JDK 17, Maven and the Java tools come from shared/packages.nix (the flake
  # overlay gives this machine a JDK with the extra root CA). Selenium suites:
  # WebDriverManager finds google-chrome on PATH and downloads the matching
  # chromedriver, which runs through nix-ld.
  environment.systemPackages = [ pkgs.google-chrome ];
  environment.variables.JAVA_HOME = "${pkgs.temurin-bin-17}";

  users.users.${username} = {
    isNormalUser = true;
    # Keep the user manager (Hermes gateway, gbrain autopilot, Hindsight
    # backup timer) running without an open WSL session.
    linger = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      # FIXME: uncomment the next line if you want to run docker without sudo
      # "docker"
    ];
    # FIXME: add your own hashed password
    # hashedPassword = "";
    # FIXME: add your own ssh public key
    # openssh.authorizedKeys.keys = [
    #   "ssh-rsa ..."
    # ];
  };

  home-manager.users.${username} = {
    imports = [
      ../home.nix
    ];
  };

  # Release of the first install (NixOS-WSL 2605.7.2); do not change later.
  system.stateVersion = "26.05";

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = username;
    startMenuLaunchers = true;

  };

  nix = {
    settings = {
      # No trusted-users: a trusted user can get root through the Nix daemon,
      # which would bypass the sudo password.
      # FIXME: use your access tokens from secrets.json here to be able to clone private repos on GitHub and GitLab
      # access-tokens = [
      #   "github.com=${secrets.github_token}"
      #   "gitlab.com=OAuth2:${secrets.gitlab_token}"
      # ];

      accept-flake-config = true;
      auto-optimise-store = true;
    };

    registry = {
      nixpkgs = {
        flake = inputs.nixpkgs;
      };
    };

    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];

    # package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
