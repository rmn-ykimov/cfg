{
  description = "NixOS";

  inputs.shared.url = "path:../shared/inputs";

  outputs = { self, shared, ... }:
  let
    nixpkgs = shared.inputs.nixpkgs;
    home-manager = shared.inputs.home-manager;
  in
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
            ./configuration.nix
            
            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.roman = import ./home.nix;
            }
        ];
      };
    };
  };
}
