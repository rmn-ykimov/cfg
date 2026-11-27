# Nix settings for every host (NixOS and nix-darwin share these options).
{ ... }:
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # Hard-link identical files on every build.
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
  nixpkgs.config.allowUnfree = true;
}
