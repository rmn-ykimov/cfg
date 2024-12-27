{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "blender"
      "vlc"
      "godot-mono"
    ];
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
