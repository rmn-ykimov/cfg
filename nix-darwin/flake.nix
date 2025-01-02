{
  description = "nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  {
    darwinConfigurations."Romans-MacBook-Air" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [ 
          ./modules/system-packages.nix
          ./modules/homebrew.nix
          ./modules/system-defaults.nix
          ./modules/nix-settings.nix
          ./modules/nixpkgs-settings.nix
          ./modules/darwin-settings.nix
          ./modules/applications-setup.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon Only
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "roman";
            };
          }
        ];
    };
  };
}
