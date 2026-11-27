{ pkgs, lib, username, ... }:
{
  # Database for Hindsight and gbrain. Port 5434 is what their configs use;
  # always write the port: WSL distros share one network.
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_18;
    extensions = ps: [ ps.pgvector ];
    settings.port = 5434;
    enableTCPIP = false; # loopback only

    ensureDatabases = [ "hindsight" "gbrain" ];
    ensureUsers = [
      { name = "hindsight"; ensureDBOwnership = true; }
      {
        name = "gbrain";
        ensureDBOwnership = true;
        # gbrain migrations create event triggers and enable RLS.
        ensureClauses = { superuser = true; bypassrls = true; };
      }
    ];

    # Socket without password for the user; gbrain's client cannot use the
    # socket, so it (and Hindsight) also get loopback TCP with a password
    # from a mode-600 file in $HOME.
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
  };
}
