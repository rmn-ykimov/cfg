{
  description = "nix-darwin configuration";

  inputs.shared.url = "path:../shared";

  outputs = { self, shared, ... }:
  let
    nix-darwin = shared.inputs.nix-darwin;
    nixpkgs = shared.inputs.nixpkgs;
    nixpkgs-unstable = shared.inputs.nixpkgs-unstable;
    nix-homebrew = shared.inputs.nix-homebrew;
    home-manager = shared.inputs.home-manager;
  in
  {
    darwinConfigurations."Romans-MacBook-Air" = nix-darwin.lib.darwinSystem {
      specialArgs = { 
        inherit self;
        pkgs-unstable = import nixpkgs-unstable {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
      };
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
