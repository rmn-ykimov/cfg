{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "vlc"
      "blender"
      "jupyterlab"
    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    
  };
}
