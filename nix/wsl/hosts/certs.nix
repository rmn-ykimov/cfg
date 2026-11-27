{ config, ... }:
let
  bundle = "/etc/ssl/certs/ca-certificates.crt";

  # Extra root CA, kept on the machine and not in this repo (root-owned, so
  # only sudo can swap it). Reading it needs `nixos-rebuild --impure`.
  extraCaFile = "/etc/nixos/extra-ca/root-ca.pem";
  extraCa =
    if builtins.pathExists extraCaFile then
      builtins.path {
        path = extraCaFile;
        name = "extra-root-ca.pem";
      }
    else
      throw "extra root CA not readable at ${extraCaFile}: rebuild with --impure, and put the PEM there (sudo) if it is missing";
in
{
  # System bundle: curl, git, Nix, Go.
  security.pki.certificateFiles = [ extraCa ];

  # nixpkgs JDKs build their own cacerts from pkgs.cacert, so the JDK from
  # shared/packages.nix gets the CA here.
  nixpkgs.overlays = [
    (final: prev: {
      temurin-bin-25 = prev.temurin-bin-25.override {
        cacert = prev.cacert.override { extraCertificateFiles = [ extraCa ]; };
      };
    })
  ];

  # Prebuilt Python (Hermes, uv) looks for /etc/ssl/cert.pem.
  environment.etc."ssl/cert.pem".source =
    config.environment.etc."ssl/certs/ca-certificates.crt".source;

  # Node, Python requests and uv ignore the system store; user services do
  # not read shell variables, so they get the same values from systemd.
  environment.variables = {
    SSL_CERT_FILE = bundle;
    NODE_EXTRA_CA_CERTS = bundle;
    REQUESTS_CA_BUNDLE = bundle;
  };
  systemd.user.settings.Manager.DefaultEnvironment =
    ''"SSL_CERT_FILE=${bundle}" "NODE_EXTRA_CA_CERTS=${bundle}" "REQUESTS_CA_BUNDLE=${bundle}"'';
}
