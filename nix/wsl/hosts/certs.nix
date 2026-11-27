{ config, extraCa, ... }:
let
  bundle = "/etc/ssl/certs/ca-certificates.crt";
in
{
  # Extra root CA (see flake.nix) in the system bundle: curl, git, Nix, Go.
  security.pki.certificateFiles = [ extraCa ];

  # Prebuilt Python (Hermes, uv) looks for /etc/ssl/cert.pem.
  environment.etc."ssl/cert.pem".source = config.environment.etc."ssl/certs/ca-certificates.crt".source;

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
