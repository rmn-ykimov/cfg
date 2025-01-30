{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      # ll = "ls -lah";
      h = "history";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
  };
}
