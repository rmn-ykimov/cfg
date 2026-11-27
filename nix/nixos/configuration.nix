{ pkgs, username, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Podgorica";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # GNOME on X11, US keyboard
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.printing.enable = true;

  # Sound through PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "Roman";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
  home-manager.users.${username} = import ./home.nix;

  programs.zsh.enable = true;
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    ghostty
    obsidian
  ];

  # Release of the first install; do not change.
  system.stateVersion = "25.05";
}
