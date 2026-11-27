# macOS host: everything nix-darwin specific; shared settings come from the root flake.
{ username, ... }:
{
  imports = [
    ./modules/packages/system-packages.nix
    ./modules/packages/homebrew.nix
    ./modules/system/system-defaults.nix
    ./modules/system/darwin-settings.nix
    ./modules/system/applications-setup.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.primaryUser = username;

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    # User owning the Homebrew prefix
    user = username;
  };

  home-manager.users.${username} = import ./modules/home.nix;
}
