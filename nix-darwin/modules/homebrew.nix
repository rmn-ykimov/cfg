{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks = [
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
