# macOS-only system packages; the shared list comes through Home Manager
# (nix/shared/home.nix), like on the other hosts.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mkalias

    # GUI applications (moved to Homebrew casks in homebrew.nix)
  ];
}
