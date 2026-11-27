{
  username,
  hostname,
  pkgs,
  ...
}:
{
  imports = [
    ./certs.nix
    ./nix-ld.nix
    ./postgresql.nix
  ];

  wsl = {
    enable = true;
    defaultUser = username;
    startMenuLaunchers = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
  };

  networking.hostName = hostname;
  time.timeZone = "Europe/Budapest";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    # Keeps user services (Hermes gateway, gbrain autopilot, Hindsight
    # backup) running without an open WSL window.
    linger = true;
  };
  home-manager.users.${username} = import ../home.nix;

  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = [ pkgs.zsh ];

  # sudo asks for the password (set it from Windows:
  # wsl -d NixOS -u root passwd <user>). No trusted-users: that would give
  # root through the Nix daemon and bypass the password.
  security.sudo.wheelNeedsPassword = true;

  # WSL has no console; getty@tty1 fails on every switch since 26.11.
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Local embeddings for gbrain; port 11435 is what ~/.gbrain/serve-mcp.sh uses.
  services.ollama = {
    enable = true;
    host = "127.0.0.1";
    port = 11435;
    loadModels = [ "nomic-embed-text" ];
  };

  # JDK, Maven and Java tools come from shared/packages.nix. Selenium:
  # WebDriverManager downloads chromedriver for this Chrome; it runs via nix-ld.
  environment.systemPackages = [ pkgs.google-chrome ];
  environment.variables.JAVA_HOME = "${pkgs.temurin-bin-25}";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  # Release of the first install (NixOS-WSL 2605.7.2); do not change.
  system.stateVersion = "26.05";
}
