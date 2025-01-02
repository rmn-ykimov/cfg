{ config, pkgs, ... }:

{
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nix.optimise.automatic = true;

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
}
