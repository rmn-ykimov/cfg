{
  description = "NixOS-WSL";

  inputs.shared.url = "path:../shared/inputs";

  outputs =
    { shared, ... }:
    let
      inherit (shared.inputs) nixpkgs home-manager nixos-wsl nix-index-database;
      system = "x86_64-linux";
      username = "roman";
      hostname = "nixos";

      # Extra root CA, kept on the machine and not in this repo (root-owned,
      # so only sudo can swap it). Reading it needs `nixos-rebuild --impure`.
      extraCaFile = "/etc/nixos/extra-ca/root-ca.pem";
      extraCa =
        if builtins.pathExists extraCaFile then
          builtins.path {
            path = extraCaFile;
            name = "extra-root-ca.pem";
          }
        else
          throw "extra root CA not readable at ${extraCaFile}: rebuild with --impure, and put the PEM there (sudo) if it is missing";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        # nixpkgs JDKs build their own cacerts from pkgs.cacert, so the JDK
        # from shared/packages.nix gets the extra CA here.
        overlays = [
          (final: prev: {
            temurin-bin-25 = prev.temurin-bin-25.override {
              cacert = prev.cacert.override { extraCertificateFiles = [ extraCa ]; };
            };
          })
        ];
      };

      specialArgs = {
        inputs = shared.inputs;
        inherit username hostname extraCa nix-index-database;
      };
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system pkgs specialArgs;
        modules = [
          nixos-wsl.nixosModules.wsl
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = specialArgs;
          }
          ./hosts/wsl.nix
        ];
      };
    };
}
