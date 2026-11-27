{ pkgs, lib, username, ... }:
{
  # One PostgreSQL from nixpkgs for Hindsight and gbrain, instead of the
  # downloaded pg0 binaries. Extensions: pgvector here; pg_trgm, btree_gin,
  # pgcrypto and amcheck ship with the server.
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    extensions = ps: [ ps.pgvector ];

    # Port 5434, not the default 5432: the Hindsight profile and gbrain's
    # config.json point here.
    settings.port = 5434;

    ensureDatabases = [ "hindsight" "gbrain" ];
    ensureUsers = [
      { name = "hindsight"; ensureDBOwnership = true; }
      {
        name = "gbrain";
        ensureDBOwnership = true;
        # gbrain schema migrations create event triggers and enable RLS.
        ensureClauses = { superuser = true; bypassrls = true; };
      }
    ];

    # Socket with peer auth for psql and Hindsight; gbrain's postgres.js
    # client ignores a socket path in the URL, so gbrain (and Hindsight, if
    # needed) also get loopback TCP with scram passwords. Passwords live in
    # mode-600 files in $HOME, never in this repo or the Nix store.
    # Note: all WSL distros share one network namespace, so a URL without
    # :5434 reaches whatever another distro runs on 5432; spell the port out.
    identMap = ''
      local ${username} hindsight
      local ${username} gbrain
      local postgres postgres
    '';
    authentication = lib.mkForce ''
      local all postgres peer
      local all all peer map=local
      host gbrain,hindsight gbrain,hindsight 127.0.0.1/32 scram-sha-256
      host gbrain,hindsight gbrain,hindsight ::1/128 scram-sha-256
    '';
    # listen_addresses stays "localhost" (loopback only).
    enableTCPIP = false;
  };
}
