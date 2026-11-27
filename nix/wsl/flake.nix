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
      # Extra root CA, kept on the machine and not in this repo. The file
      # lives under /etc/nixos (root-owned, so only sudo can swap the CA the
      # whole system trusts). Reading a path outside the flake needs
      #   sudo nixos-rebuild switch --impure --flake .#nixos
      # Pure evaluation cannot see the file either, so a missing --impure
      # also ends in the throw below.
      extraCaFile = "/etc/nixos/extra-ca/root-ca.pem";
      extraCa =
        if builtins.pathExists extraCaFile then
          builtins.path {
            path = extraCaFile;
            name = "extra-root-ca.pem";
          }
        else
          throw "extra root CA not readable at ${extraCaFile}: rebuild with --impure, and put the PEM there (sudo) if it is missing";

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

            # The JDK from shared/packages.nix, rebuilt with this machine's
            # extra root CA: nixpkgs JDKs build their cacerts keystore from
            # pkgs.cacert, not from the system bundle. Maven in the shared
            # list is pinned to the same attribute, so it gets this one too.
            (final: prev: {
              temurin-bin-17 = prev.temurin-bin-17.override {
                cacert = prev.cacert.override {
                  extraCertificateFiles = [ extraCa ];
                };
              };
            })
          ];
        });

      configurationDefaults = args: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-backup";
        home-manager.extraSpecialArgs = args;
      };

      argDefaults = {
        inherit self nix-index-database extraCa;
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
