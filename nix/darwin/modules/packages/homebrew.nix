{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "vlc"
      "blender"
      "jupyterlab"
      "godot"
    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    
  };
}
