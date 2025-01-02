{ config, pkgs, ... }:

{

  nix = {
    settings.experimental-features = "nix-command flakes";
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

}
