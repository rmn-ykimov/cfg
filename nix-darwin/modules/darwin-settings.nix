{ config, pkgs, self, ... }:

{
  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;
}
