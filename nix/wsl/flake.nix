{
  description = "NixOS configuration";

  inputs.shared.url = "path:../shared/inputs";

  outputs =
    input@{ self, shared, ... }:
    let
      nixpkgs = shared.inputs.nixpkgs;
      home-manager = shared.inputs.home-manager;
      nur = shared.inputs.nur;
      nixos-wsl = shared.inputs.nixos-wsl;
      nix-index-database = shared.inputs.nix-index-database;
    in
    with shared.inputs;
    let
      secrets = builtins.fromJSON (builtins.readFile "${self}/secrets.json");

      nixpkgsWithOverlays =
        system:
        (import nixpkgs rec {
          inherit system;

          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              # FIXME:: add any insecure packages you absolutely need here
            ];
          };

          overlays = [
            nur.overlays.default
          ];
        });

      configurationDefaults = args: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-backup";
        home-manager.extraSpecialArgs = args;
      };

      argDefaults = {
        inherit secrets self nix-index-database;
        inputs = shared.inputs;
        channels = {
          inherit nixpkgs;
        };
      };

      mkNixosConfiguration =
        {
          system ? "x86_64-linux",
          hostname,
          username,
          args ? { },
          modules,
        }:
        let
          specialArgs = argDefaults // { inherit hostname username; } // args;
        in
        nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          pkgs = nixpkgsWithOverlays system;
          modules = [
            (configurationDefaults specialArgs)
            home-manager.nixosModules.home-manager
          ]
          ++ modules;
        };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

      nixosConfigurations.nixos = mkNixosConfiguration {
        hostname = "nixos";
        username = "roman";
        modules = [
          nixos-wsl.nixosModules.wsl
          ./hosts/wsl.nix
        ];
      };
    };
}
