{ ... }:

{
  imports = [ ../../shared/home.nix ];

  home.stateVersion = "26.11";

  # Hermes CLI lives in ~/.local/bin
  home.sessionPath = [ "$HOME/.local/bin" ];
}
