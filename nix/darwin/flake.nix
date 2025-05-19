{
  description = "nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, ... }:
  {
    darwinConfigurations."Romans-MacBook-Air" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [ 
          ./modules/packages/system-packages.nix
          ./modules/packages/homebrew.nix
          ./modules/system/system-defaults.nix
          ./modules/nix-settings.nix
          ./modules/system/darwin-settings.nix
          ./modules/system/applications-setup.nix
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

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.roman = import ./modules/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }

          {
            system.primaryUser = "roman";
          }

        ];
    };
  };
}
