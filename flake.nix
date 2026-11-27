{
  description = "nix-darwin, NixOS and NixOS-WSL hosts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      nix-homebrew,
      nixos-wsl,
      ...
    }:
    let
      username = "roman";
      specialArgs = { inherit inputs self username; };

      # Shared by every host: Nix settings and Home Manager wiring.
      common = [
        ./nix/shared/nix.nix
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm-backup";
            extraSpecialArgs = specialArgs;
          };
        }
      ];

      nixos =
        modules:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = common ++ [ home-manager.nixosModules.home-manager ] ++ modules;
        };
    in
    {
      # sudo nixos-rebuild switch --impure --flake ~/cfg#wsl
      nixosConfigurations.wsl = nixos [
        nixos-wsl.nixosModules.wsl
        ./nix/wsl/hosts/wsl.nix
      ];

      # sudo nixos-rebuild switch --flake ~/cfg#desktop
      nixosConfigurations.desktop = nixos [ ./nix/nixos/configuration.nix ];

      # darwin-rebuild switch --flake ~/cfg#mac
      darwinConfigurations.mac = nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = common ++ [
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          ./nix/darwin/default.nix
        ];
      };
    };
}
