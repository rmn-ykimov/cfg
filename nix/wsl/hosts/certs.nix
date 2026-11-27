{ config, extraCa, ... }:
let
  bundle = "/etc/ssl/certs/ca-certificates.crt";
in
{
  # Extra root CA for the local network (public certificate, no private key);
  # the file and the --impure rule are described in flake.nix.
  # Adding it to the system bundle makes curl, git, Nix, Go (ollama) and
  # Python with certifi-free lookups trust it.
  security.pki.certificateFiles = [ extraCa ];

  # Prebuilt runtimes (python-build-standalone used by Hermes pm, uv Python)
  # look for /etc/ssl/cert.pem, which NixOS does not create.
  environment.etc."ssl/cert.pem".source = config.environment.etc."ssl/certs/ca-certificates.crt".source;

  # Runtimes that ignore the system store: Node (Hermes, gbrain), Python
  # requests/httpx, uv.
  environment.variables = {
    SSL_CERT_FILE = bundle;
    NODE_EXTRA_CA_CERTS = bundle;
    REQUESTS_CA_BUNDLE = bundle;
  };

  # User services (Hermes gateway, Hindsight daemon) do not read shell
  # variables; give the user manager the same defaults.
  systemd.user.settings.Manager.DefaultEnvironment =
    ''"SSL_CERT_FILE=${bundle}" "NODE_EXTRA_CA_CERTS=${bundle}" "REQUESTS_CA_BUNDLE=${bundle}"'';
}
