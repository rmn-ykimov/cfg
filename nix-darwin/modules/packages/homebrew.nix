{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "vlc"
      #"godot-mono"
      #"blender"
    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    
  };
}
